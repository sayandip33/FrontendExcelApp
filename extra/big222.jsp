<%@ page language="java" session="true" %>
<%@ page import="com.dreyfus.gama.ivr.dto.*" %>
<%@ page import="com.dreyfus.gama.ivr.utils.DataFormatter" %>
<%@ page import="java.util.*" %>
<%@ page import="org.owasp.encoder.Encode" %>

<vxml version="2.1" xmlns="http://www.w3.org/2001/vxml">

<jsp:useBean id="mutualSSLDto" scope="session" class="com.dreyfus.gama.ivr.dto.MutualSs1DTO" />

<form id="readfivechecks">
  <block>
    <var name="ctr" expr="0"/>
    <assign name="currentMenu" expr="'readfivechecks'"/>
    <%
      List checks = (List) request.getAttribute("checks");
      if (checks != null) {
        for (int i = 0; i < checks.size(); i++) {
          com.dreyfus.gama.ivr.dto.Transaction item = (com.dreyfus.gama.ivr.dto.Transaction) checks.get(i);
          com.dreyfus.gama.ivr.dto.DreyfusDate chargeDateVar = item.getDate();
          com.dreyfus.gama.ivr.dto.ASMoney amountVar = item.getAmount();
          String checkNumberVar = item.getNumber();

          String chargeDate = chargeDateVar.toString("MMddyyyy");
          String yearPhrase = DataFormatter.formatYear(chargeDate, "year");
          String decadePhrase = DataFormatter.formatYear(chargeDate, "decade");
          String monthPhrase = DataFormatter.formatMonth(chargeDate);
          String datePhrase = DataFormatter.formatDate(chargeDate);
          String checkNumber = checkNumberVar;
          String amount = amountVar.toString();
          amount = DataFormatter.formatCurrency(amount);

          if (i < 5) {
    %>

    <var name="date" expr="'<%=datePhrase%>'"/>
    <var name="month" expr="'<%=monthPhrase%>'"/>
    <var name="decade" expr="'<%=decadePhrase%>'"/>
    <var name="year" expr="'<%=yearPhrase%>'"/>
    <var name="checkNumber" expr="'<%=checkNumber%>'"/>
    <var name="amount" expr="'<%=amount%>'"/>

    <prompt bargein="true">
      <voice name="tom">
        <audio expr="audioUrl + 'CheckNumber.wav'">Check number</audio>
      </voice>
      <var name="checkValueArray" expr="createDataArray(checkNumber)"/>
      <foreach item="number" array="checkValueArray">
        <audio expr="standardAudioUrl + number + '.wav'">
          <voice name="tom">
            <value expr="number"/>
          </voice>
        </audio>
      </foreach>

      <voice name="tom">
        <audio expr="audioUrl + 'InTheAmountOf.wav'">in the amount of</audio>
      </voice>
      <var name="amountArray" expr="createDataArrayByDelimiter(amount)"/>
      <foreach item="number" array="amountArray">
        <audio expr="standardAudioUrl + number + '.wav'">
          <voice name="tom">
            <value expr="number"/>
          </voice>
        </audio>
      </foreach>

      <voice name="tom">
        <audio expr="audioUrl + 'ClearedOn.wav'">cleared on</audio>
        <audio expr="standardAudioUrl + month + '.wav'"><value expr="month"/></audio>
        <audio expr="standardAudioUrl + date + '.wav'"><value expr="date"/></audio>
        <audio expr="standardAudioUrl + decade + '.wav'"><value expr="decade"/></audio>
        <audio expr="standardAudioUrl + year + '.wav'"><value expr="year"/></audio>
      </voice>
      <break time="1.5s"/>
    </prompt>

    <%
          } else {
    %>
    <goto next="#additionalchecks"/>
    <%
            break;
          }
        }
      } else {
    %>
    <goto next="#noadditionalchecks"/>
    <%
      }
    %>
  </block>
</form>

<form id="nextfive">
  <block>
    <assign name="currentMenu" expr="'nextfive'"/>
    <var name="ctr" expr="0"/>
    <%
      List checks = (List) request.getAttribute("checks");
      if (checks != null) {
        for (int i = 0; i < checks.size(); i++) {
          com.dreyfus.gama.ivr.dto.Transaction item = (com.dreyfus.gama.ivr.dto.Transaction) checks.get(i);
          com.dreyfus.gama.ivr.dto.DreyfusDate chargeDateVar1 = item.getDate();
          com.dreyfus.gama.ivr.dto.ASMoney amountVar1 = item.getAmount();
          String checkNumberVar1 = item.getNumber();

          String chargeDate = chargeDateVar1.toString("MMddyyyy");
          String yearPhrase = DataFormatter.formatYear(chargeDate, "year");
          String decadePhrase = DataFormatter.formatYear(chargeDate, "decade");
          String monthPhrase = DataFormatter.formatMonth(chargeDate);
          String datePhrase = DataFormatter.formatDate(chargeDate);
          String checkNumber = checkNumberVar1;
          String amount = amountVar1.toString();
          amount = DataFormatter.formatCurrency(amount);

          if (i > 4) {
    %>

    <var name="date" expr="'<%=datePhrase%>'"/>
    <var name="month" expr="'<%=monthPhrase%>'"/>
    <var name="decade" expr="'<%=decadePhrase%>'"/>
    <var name="year" expr="'<%=yearPhrase%>'"/>
    <var name="checkNumber" expr="'<%=checkNumber%>'"/>
    <var name="amount" expr="'<%=amount%>'"/>

    <prompt bargein="true">
      <voice name="tom">
        <audio expr="audioUrl + 'CheckNumber.wav'">Check number</audio>
      </voice>
      <var name="checkValueArray" expr="createDataArray(checkNumber)"/>
      <foreach item="number" array="checkValueArray">
        <audio expr="standardAudioUrl + number + '.wav'">
          <value expr="number"/>
        </audio>
      </foreach>

      <voice name="tom">
        <audio expr="audioUrl + 'InTheAmountOf.wav'">in the amount of</audio>
      </voice>
      <var name="amountArray" expr="createDataArrayByDelimiter(amount)"/>
      <foreach item="number" array="amountArray">
        <audio expr="standardAudioUrl + number + '.wav'">
          <voice name="tom">
            <value expr="number"/>
          </voice>
        </audio>
      </foreach>

      <voice name="tom">
        <audio expr="audioUrl + 'ClearedOn.wav'">cleared on</audio>
        <audio expr="standardAudioUrl + month + '.wav'"><value expr="month"/></audio>
        <audio expr="standardAudioUrl + date + '.wav'"><value expr="date"/></audio>
        <audio expr="standardAudioUrl + decade + '.wav'"><value expr="decade"/></audio>
        <audio expr="standardAudioUrl + year + '.wav'"><value expr="year"/></audio>
      </voice>
      <break time="1s"/>
    </prompt>

    <%
          }
        }
      }
    %>
    <goto next="#noadditionalchecks"/>
  </block>
</form>

</vxml>