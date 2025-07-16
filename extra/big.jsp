<%@ page language="java" session="true" import="org.owasp.encoder.Encode, com.dreyfus.gama.ivr.dto.*, com.dreyfus.gama.ivr.utils.DataFormatter, java.util.ArrayList" %>
<%@ include file="utilities.js" %>

<jsp:useBean id="mutualSSLDto" scope="session" class="com.dreyfus.gama.ivr.dto.MutualSSLDTO" />

<?xml version="1.0" encoding="UTF-8"?>
<vxml version="2.1" revision="4"
      application="<%= Encode.forHtmlAttribute(mutualSSLDto.getMutualSslUrl()) %>/dreyfusgama/appSettings.jsp"
      xmlns="http://www.w3.org/2001/vxml">

<var name="sourceOfRequest" expr="'readFiveWithdrawals'" />

<form id="readfivewithdrawals">
  <block>
    <assign name="currentMenu" expr="'readfivewithdrawals'" />
    <%
      ArrayList<WithdrawalDTO> withdrawals = (ArrayList<WithdrawalDTO>) request.getAttribute("withdrawals");
      if (withdrawals != null) {
        int ctr = 0;
        for (WithdrawalDTO item : withdrawals) {
          if (ctr < 5) {
            String chargeDate = item.getDate().toString("MMddyyyy");
            String yearPhrase = DataFormatter.formatYear(chargeDate, "year");
            String decadePhrase = DataFormatter.formatYear(chargeDate, "decade");
            String monthPhrase = DataFormatter.formatMonth(chargeDate);
            String datePhrase = DataFormatter.formatDate(chargeDate);
            String amount = DataFormatter.formatCurrency(item.getAmount().toString());
    %>

    <var name="date" expr="'<%= datePhrase %>'" />
    <var name="month" expr="'<%= monthPhrase %>'" />
    <var name="decade" expr="'<%= decadePhrase %>'" />
    <var name="year" expr="'<%= yearPhrase %>'" />
    <var name="amount" expr="'<%= amount %>'" />

    <prompt bargein="true">
      <var name="amountArray" expr="createDataArrayByDelimiter(amount)" />
      <foreach item="number" array="amountArray">
        <audio expr="standardAudioUrl + number + '.wav'">
          <voice name="tom"><value expr="number" /></voice>
        </audio>
      </foreach>

      <voice name="tom">
        <audio expr="audioUrl + 'WasWithdrawnOn.wav'" />
        <audio expr="standardAudioUrl + month + '.wav'"><value expr="month" /></audio>
        <audio expr="standardAudioUrl + date + '.wav'"><value expr="date" /></audio>
        <audio expr="standardAudioUrl + decade + '.wav'"><value expr="decade" /></audio>
        <audio expr="standardAudioUrl + year + '.wav'"><value expr="year" /></audio>
      </voice>
      <break time="1s"/>
    </prompt>

    <%
            ctr++;
          } else {
            break;
          }
        }
    %>
    <goto next="#noadditionalwithdrawals" />
    <%
      } else {
    %>
    <goto next="#noadditionalwithdrawals" />
    <%
      }
    %>
  </block>
</form>

<form id="additionalwithdrawals">
  <field name="withdrawals">
    <prompt bargein="true">
      <voice name="tom">
        <audio expr="audioUrl + 'ToRepeatThisInformation.wav'" />
        <audio expr="audioUrl + 'PleasePressPoundNow.wav'" />
        <audio expr="audioUrl + 'ToHearNext5Withdrawals.wav'" />
        <audio expr="audioUrl + 'PleasePress1Now.wav'" />
        <audio expr="audioUrl + 'ForAdditionalAccountActivity.wav'" />
        <audio expr="audioUrl + 'PleasePress3Now.wav'" />
        <audio expr="audioUrl + 'ToReturnToMainMenu.wav'" />
        <audio expr="audioUrl + 'PleasePress9Now.wav'" />

        <%
          ProfileDTO profile = (ProfileDTO) request.getAttribute("profile");
          if (profile != null && profile.isBusinessHours() != null && profile.isBusinessHours()) {
        %>
          <audio expr="audioUrl + 'SpeakWithClientServices.wav'" />
          <audio expr="audioUrl + 'PleasePress0Now.wav'" />
        <%
          }
        %>
      </voice>
    </prompt>

    <noinput count="1">
      <audio expr="audioUrl + 'NotAValidResponse.wav'" />
      <reprompt />
    </noinput>
    <noinput count="2">
      <audio expr="audioUrl + 'NotAValidResponse.wav'" />
      <goto next="<%= Encode.forHtmlAttribute(mutualSSLDto.getMutualSslUrl()) %>/dreyfusgama/transfer" />
    </noinput>
    <nomatch count="1">
      <audio expr="audioUrl + 'NotAValidMenuOption.wav'" />
      <reprompt />
    </nomatch>
    <nomatch count="2">
      <audio expr="audioUrl + 'NotAValidMenuOption.wav'" />
      <goto next="<%= Encode.forHtmlAttribute(mutualSSLDto.getMutualSslUrl()) %>/dreyfusgama/transfer" />
    </nomatch>

    <option dtmf="1" value="nextFiveWithdrawals" />
    <option dtmf="3" value="recentAccountActivity" />
    <filled>
      <if cond="withdrawals == 'nextFiveWithdrawals'">
        <goto next="#nextfive" />
      </if>
      <if cond="withdrawals == 'recentAccountActivity'">
        <goto next="<%= Encode.forHtmlAttribute(mutualSSLDto.getMutualSslUrl()) %>/dreyfusgama/accountActivity.jsp" />
      </if>
    </filled>
  </field>
</form>

<form id="noadditionalwithdrawals">
  <field name="withdrawals">
    <prompt bargein="true">
      <voice name="tom">
        <audio expr="audioUrl + 'NoAdditionalWithdrawalsCleared.wav'" />
        <audio expr="audioUrl + 'ToRepeatThisInformation.wav'" />
        <audio expr="audioUrl + 'PleasePressPoundNow.wav'" />
        <audio expr="audioUrl + 'ForAdditionalAccountActivity.wav'" />
        <audio expr="audioUrl + 'PleasePress3Now.wav'" />
        <audio expr="audioUrl + 'ToReturnToMainMenu.wav'" />
        <audio expr="audioUrl + 'PleasePress9Now.wav'" />
        <%
          if (profile != null && profile.isBusinessHours() != null && profile.isBusinessHours()) {
        %>
          <audio expr="audioUrl + 'SpeakWithClientServices.wav'" />
          <audio expr="audioUrl + 'PleasePress0Now.wav'" />
        <%
          }
        %>
      </voice>
    </prompt>

    <noinput count="1">
      <audio expr="audioUrl + 'NotAValidResponse.wav'" />
      <reprompt />
    </noinput>
    <noinput count="2">
      <audio expr="audioUrl + 'NotAValidResponse.wav'" />
      <goto next="<%= Encode.forHtmlAttribute(mutualSSLDto.getMutualSslUrl()) %>/dreyfusgama/transfer" />
    </noinput>
    <nomatch count="1">
      <audio expr="audioUrl + 'NotAValidMenuOption.wav'" />
      <reprompt />
    </nomatch>
    <nomatch count="2">
      <audio expr="audioUrl + 'NotAValidMenuOption.wav'" />
      <goto next="<%= Encode.forHtmlAttribute(mutualSSLDto.getMutualSslUrl()) %>/dreyfusgama/transfer" />
    </nomatch>

    <option dtmf="3" value="recentAccountActivity" />
    <filled>
      <if cond="withdrawals == 'recentAccountActivity'">
        <goto next="<%= Encode.forHtmlAttribute(mutualSSLDto.getMutualSslUrl()) %>/dreyfusgama/accountActivity.jsp" />
      </if>
    </filled>
  </field>
</form>

<form id="nextfive">
  <block>
    <assign name="currentMenu" expr="'nextfive'" />
    <%
      if (withdrawals != null) {
        int ctr = 0;
        for (WithdrawalDTO item : withdrawals) {
          if (ctr > 4) {
            String chargeDate = item.getDate().toString("MMddyyyy");
            String yearPhrase = DataFormatter.formatYear(chargeDate, "year");
            String decadePhrase = DataFormatter.formatYear(chargeDate, "decade");
            String monthPhrase = DataFormatter.formatMonth(chargeDate);
            String datePhrase = DataFormatter.formatDate(chargeDate);
            String amount = DataFormatter.formatCurrency(item.getAmount().toString());
    %>
    <var name="date" expr="'<%= datePhrase %>'" />
    <var name="month" expr="'<%= monthPhrase %>'" />
    <var name="decade" expr="'<%= decadePhrase %>'" />
    <var name="year" expr="'<%= yearPhrase %>'" />
    <var name="amount" expr="'<%= amount %>'" />

    <prompt bargein="true">
      <var name="amountArray" expr="createDataArrayByDelimiter(amount)" />
      <foreach item="number" array="amountArray">
        <audio expr="standardAudioUrl + number + '.wav'">
          <voice name="tom"><value expr="number" /></voice>
        </audio>
      </foreach>

      <voice name="tom">
        <audio expr="audioUrl + 'WasWithdrawnOn.wav'" />
        <audio expr="standardAudioUrl + month + '.wav'"><value expr="month" /></audio>
        <audio expr="standardAudioUrl + date + '.wav'"><value expr="date" /></audio>
        <audio expr="standardAudioUrl + decade + '.wav'"><value expr="decade" /></audio>
        <audio expr="standardAudioUrl + year + '.wav'"><value expr="year" /></audio>
      </voice>
      <break time="1s"/>
    </prompt>
    <%
          }
          ctr++;
        }
      }
    %>
    <goto next="#noadditionalwithdrawals" />
  </block>
</form>

</vxml>
