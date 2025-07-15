<?xml version="1.0" encoding="UTF-8"?>
<%@ page language="java" session="true" %>
<%@ page import="org.owasp.encoder.Encode" %>
<%@ page import="com.dreyfus.gama.ivr.dto.*" %>
<%@ page import="com.dreyfus.gama.ivr.utils.DataFormatter" %>
<%@ page import="java.util.ArrayList" %>
<%@ include file="utilities.js" %>
<jsp:useBean id="mutualSSLDto" scope="session" class="com.dreyfus.gama.ivr.dto.MutualSsLDTO" />

<vxml version="2.1" revision="4"
      application="<%= Encode.forHtmlAttribute(mutualSSLDto.getMutualSslUrl()) %>/dreyfusgama/appSettings.jsp"
      xmlns="http://www.w3.org/2001/vxml">

  <form id="readGIDF">
    <block>
      <assign name="currentMenu" expr="'readGIDF'" />
      <log label="com.tellme.proprietary.dreyfusgama.getgeneralinsureddeposit.task.success" />

      <prompt bargein="true">
        <%
          System.out.println("Entering readGIDF.jsp");
          ArrayList<FundYieldInfoDTO> gidfRates = (ArrayList<FundYieldInfoDTO>) session.getAttribute("gidfRates");

          if (gidfRates != null) {
            for (FundYieldInfoDTO item : gidfRates) {
              String asOfDate = item.getAsOfDate().toString("MMddyyyy");

              String yearPhrase = DataFormatter.formatYear(asOfDate, "year");
              String decadePhrase = DataFormatter.formatYear(asOfDate, "decade");
              String monthPhrase = DataFormatter.formatMonth(asOfDate);
              String datePhrase = DataFormatter.formatDate(asOfDate);

              String sevenDayYield = DataFormatter.formatInterestRate(item.getSevenDayYield());

              String fundCode = item.getFundCode();
              System.out.println("Fund Code [Before] :: " + fundCode);

              // Remove leading zeroes
              int startIndex = 0;
              for (int i = 0; i < fundCode.length(); i++) {
                if (fundCode.charAt(i) == '0') {
                  startIndex = i + 1;
                } else {
                  break;
                }
              }
              fundCode = fundCode.substring(startIndex);

              System.out.println("asOfDate :: " + asOfDate);
              System.out.println("yearPhrase :: " + yearPhrase);
              System.out.println("decadePhrase :: " + decadePhrase);
              System.out.println("monthPhrase :: " + monthPhrase);
              System.out.println("datePhrase :: " + datePhrase);
              System.out.println("Seven Day Yield :: " + sevenDayYield);
              System.out.println("Fund Code [After] :: " + fundCode);
        %>

        <var name="date" expr="'<%= datePhrase %>'" />
        <var name="month" expr="'<%= monthPhrase %>'" />
        <var name="decade" expr="'<%= decadePhrase %>'" />
        <var name="year" expr="'<%= yearPhrase %>'" />
        <var name="sevenDayYield" expr="'<%= sevenDayYield %>'" />
        <var name="fundCode" expr="'<%= fundCode %>'" />

        <voice name="tom">
          <audio expr="audioUrl + 'For.wav'">For</audio>
          <audio expr="standardAudioUrl + month + '.wav'"><value expr="month" /></audio>
          <audio expr="standardAudioUrl + date + '.wav'"><value expr="date" /></audio>
          <audio expr="standardAudioUrl + decade + '.wav'"><value expr="decade" /></audio>
          <audio expr="standardAudioUrl + year + '.wav'"><value expr="year" /></audio>

          <audio expr="audioUrl + 'The.wav'">The</audio>
          <audio expr="audioUrl + fundCode + '.wav'"><value expr="fundCode" /></audio>

          <audio expr="audioUrl + 'HasASevenDayYieldOf.wav'">has a 7 day yield of</audio>
        </voice>

        <var name="percentArray" expr="createDataArrayByDelimiter(sevenDayYield)" />
        <foreach item="element" array="percentArray">
          <audio expr="standardAudioUrl + element + '.wav'">
            <voice name="tom">
              <value expr="element" />
            </voice>
          </audio>
        </foreach>

        <voice name="tom">
          <audio expr="audioUrl + 'Percent.wav'">percent</audio>
        </voice>

        <break time="1s" />

        <%
            } // end for
          } // end if
        %>
      </prompt>

      <goto next="<%= Encode.forHtmlAttribute(mutualSSLDto.getMutualSslUrl()) %>/dreyfusgama/getGeneralInsuredDeposit.jsp" />
    </block>
  </form>
</vxml>
