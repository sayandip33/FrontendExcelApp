<%@ page language="java" session="true" %>
<%@ page import="com.dreyfus.gama.ivr.dto.*" %>
<%@ page import="com.dreyfus.gama.ivr.utils.DataFormatter" %>
<%@ page import="java.util.*" %>
<%@ page import="org.owasp.encoder.Encode" %>

<vxml version="2.1" xmlns="http://www.w3.org/2001/vxml">

<jsp:useBean id="mutualSSLDto" scope="session" class="com.dreyfus.gama.ivr.dto.MutualSs1DTO" />

<form id="nextfive">
  <block>
    <assign name="currentMenu" expr="'nextfive'"/>
    <var name="ctr" expr="0"/>
    <%
      List charges = (List) request.getAttribute("charges");
      if (charges != null) {
        for (int i = 0; i < charges.size(); i++) {
          com.dreyfus.gama.ivr.dto.Transaction item = (com.dreyfus.gama.ivr.dto.Transaction) charges.get(i);
          com.dreyfus.gama.ivr.dto.DreyfusDate chargeDateVar1 = item.getDate();
          com.dreyfus.gama.ivr.dto.ASMoney amountVar1 = item.getAmount();

          String chargeDate = chargeDateVar1.toString("MMddyyyy");
          String yearPhrase = DataFormatter.formatYear(chargeDate, "year");
          String decadePhrase = DataFormatter.formatYear(chargeDate, "decade");
          String monthPhrase = DataFormatter.formatMonth(chargeDate);
          String datePhrase = DataFormatter.formatDate(chargeDate);

          String amountVal = amountVar1.toString();
          String amount = amountVar1.toString();
          amount = amount.replace("-", "");
          amount = DataFormatter.formatCurrency(amount);

          if (i > 4) {
    %>

    <var name="date" expr="'<%=datePhrase%>'"/>
    <var name="month" expr="'<%=monthPhrase%>'"/>
    <var name="decade" expr="'<%=decadePhrase%>'"/>
    <var name="year" expr="'<%=yearPhrase%>'"/>
    <var name="amount" expr="'<%=amount%>'"/>
    <var name="amountVal" expr="'<%=amountVal%>'"/>

    <log>Amount: <value expr="amount"/></log>

    <prompt bargein="true">
      <if cond="amountVal != null &amp;&amp; amountVal.slice(0,1) != '-' &amp;&amp; amountVal != '0.00'">
        <audio expr="audioUrl + 'AChargeFor.wav'">A charge for</audio>
      <else/>
        <audio expr="audioUrl + 'ACreditFor.wav'">A credit for</audio>
      </if>
      <var name="amountArray" expr="createDataArrayByDelimiter(amount)"/>
      <foreach item="number" array="amountArray">
        <audio expr="standardAudioUrl + number + '.wav'">
          <voice name="tom">
            <value expr="number"/>
          </voice>
        </audio>
      </foreach>
      <voice name="tom">
        <audio expr="audioUrl + 'WasPostedOn.wav'">was posted on</audio>
        <audio expr="standardAudioUrl + month + '.wav'"><value expr="month"/></audio>
        <audio expr="standardAudioUrl + date + '.wav'"><value expr="date"/></audio>
        <audio expr="standardAudioUrl + decade + '.wav'"><value expr="decade"/></audio>
        <audio expr="standardAudioUrl + year + '.wav'"><value expr="year"/></audio>
      </voice>
      <break time="1s"/>
    </prompt>

    <%
          } // end if i > 4
        } // end for loop
      } // end if charges != null
    %>
    <goto next="#noadditionalcharges"/>
  </block>
</form>

</vxml>