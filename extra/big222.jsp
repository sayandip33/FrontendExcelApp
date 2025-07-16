<%@ page language="java" session="true" %>
<%@ page import="com.dreyfus.gama.ivr.dto.*" %>
<%@ page import="com.dreyfus.gama.ivr.utils.DataFormatter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="org.owasp.encoder.Encode" %>
<%@ include file="utilities.js" %>
<%
    MutualSs1DTO mutualSSLDto = (MutualSs1DTO) session.getAttribute("mutualSSLDto");
    ArrayList<ChargeDTO> charges = (ArrayList<ChargeDTO>) request.getAttribute("charges");
    ProfileDTO profile = (ProfileDTO) request.getAttribute("profile");
    String mutualUrl = Encode.forHtmlAttribute(mutualSSLDto.getMutualSslUrl());
%>
<?xml version="1.0" encoding="UTF-8"?>
<vxml version="2.1" revision="4" application="<%= mutualUrl %>/dreyfusgama/appSettings.jsp" xmlns="http://www.w3.org/2001/vxml">

<var name="sourceOfRequest" expr="'readFiveCharges'"/>
<form id="readfivecharges">
  <block>
    <assign name="currentMenu" expr="'readfivecharges'"/>
    <var name="ctr" expr="0"/>
    <% if (charges != null && !charges.isEmpty()) { %>
      <% int ctr = 0; %>
      <% for (ChargeDTO item : charges) {
          if (ctr >= 5) break;
          DreyfusDate chargeDateVar = item.getDate();
          ASMoney amountVar = item.getAmount();
          String chargeDate = chargeDateVar.toString("MMddyyyy");
          String yearPhrase = DataFormatter.formatYear(chargeDate, "year");
          String decadePhrase = DataFormatter.formatYear(chargeDate, "decade");
          String monthPhrase = DataFormatter.formatMonth(chargeDate);
          String datePhrase = DataFormatter.formatDate(chargeDate);
          String amountVal = amountVar.toString();
          String amount = amountVal.replace("-", "");
          amount = DataFormatter.formatCurrency(amount);
      %>
      <var name="date" expr="'<%= datePhrase %>'"/>
      <var name="month" expr="'<%= monthPhrase %>'"/>
      <var name="decade" expr="'<%= decadePhrase %>'"/>
      <var name="year" expr="'<%= yearPhrase %>'"/>
      <var name="amount" expr="'<%= amount %>'"/>
      <var name="amountVal" expr="'<%= amountVal %>'"/>
      <log> Amount : <value expr="amount"/> </log>
      <prompt bargein="true">
        <if cond="amountVal != null &amp;&amp; amountVal.slice(0,1) != '-' &amp;&amp; amountVal != '0.00'">
          <audio expr="audioUrl+'AChargeFor.wav'">A charge for</audio>
        <else/>
          <audio expr="audioUrl+'ACreditFor.wav'">A credit for</audio>
        </if>
        <var name="amountArray" expr="createDataArrayByDelimiter(amount)"/>
        <foreach item="number" array="amountArray">
          <audio expr="standardAudioUrl + number + '.wav'">
            <voice name="tom"><value expr="number"/></voice>
          </audio>
        </foreach>
        <voice name="tom">
          <audio expr="audioUrl+'WasPostedon.wav'">was posted on</audio>
          <audio expr="standardAudioUrl + month + '.wav'"><value expr="month"/></audio>
          <audio expr="standardAudioUrl + date + '.wav'"><value expr="date"/></audio>
          <audio expr="standardAudioUrl + decade + '.wav'"><value expr="decade"/></audio>
          <audio expr="standardAudioUrl + year + '.wav'"><value expr="year"/></audio>
        </voice>
        <break time="1s"/>
      </prompt>
      <% ctr++; } %>
      <goto next="#noadditionalcharges"/>
    <% } else { %>
      <goto next="#noadditionalcharges"/>
    <% } %>
  </block>
</form>

<form id="noadditionalcharges">
  <field name="charges">
    <prompt bargein="true">
      <voice name="tom">
        <% if (profile != null && profile.getAccountActivityMenuType() != null) {
             int type = profile.getAccountActivityMenuType();
             if (type == 0) { %>
               <audio expr="audioUrl+'NoAdditionalMastercardCleared.wav'"/>
        <%   } else if (type == 1) { %>
               <audio expr="audioUrl+'NoAdditionalDebitMastercardChargeCleared.wav'"/>
        <%   } else if (type == 2) { %>
               <audio expr="audioUrl+'NoAdditionalDebitChargeCleared.wav'"/>
        <%   }
           } %>
        <audio expr="audioUrl+'ToRepeatThisInformation.wav'"/>
        <audio expr="audioUrl+'PleasePressPoundNow.wav'"/>
        <audio expr="audioUrl+'ForAdditionalAccountActivity.wav'"/>
        <audio expr="audioUrl+'PleasePress3Now.wav'"/>
        <audio expr="audioUrl+'ToReturnToMainMenu.wav'"/>
        <audio expr="audioUrl+'PleasePress9Now.wav'"/>
        <% if (profile != null && profile.isBusinessHours()) { %>
          <audio expr="audioUrl+'SpeakWithClientServices.wav'"/>
          <audio expr="audioUrl+'PleasePress0Now.wav'"/>
        <% } %>
      </voice>
    </prompt>
    <noinput count="1">
      <audio expr="audioUrl+'NotAValidResponse.wav'"><voice name="tom">That is not a valid response</voice></audio>
      <reprompt/>
    </noinput>
    <noinput count="2">
      <audio expr="audioUrl+'NotAValidResponse.wav'"><voice name="tom">That is not a valid response</voice></audio>
      <goto next="<%= mutualUrl %>/dreyfusgama/transfer"/>
    </noinput>
    <nomatch count="1">
      <audio expr="audioUrl+'NotAValidMenuOption.wav'"><voice name="tom">That is not a valid menu option</voice></audio>
      <reprompt/>
    </nomatch>
    <nomatch count="2">
      <audio expr="audioUrl+'NotAValidMenuOption.wav'"><voice name="tom">That is not a valid menu option</voice></audio>
      <goto next="<%= mutualUrl %>/dreyfusgama/transfer"/>
    </nomatch>
    <option dtmf="3" value="recentAccountActivity"/>
    <filled>
      <if cond="charges == 'recentAccountActivity'">
        <break time="1s"/>
        <goto next="<%= mutualUrl %>/dreyfusgama/accountActivity.jsp"/>
      </if>
    </filled>
  </field>
</form>

</vxml>
