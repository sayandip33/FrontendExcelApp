<%
HttpSession session = request.getSession();
String httpSessionId = session.getId();
%>

<vxml version="2.1">

  <var name="httpSessionId" expr="'<%= httpSessionId %>'"/>

  <form>
    <block>

      <log> mapped dnis is <value expr="mappedDnis"/></log>
      <log> call path code is <value expr="callPathCode"/></log>
      <log> client code is <value expr="clientCode"/></log>
      <log> client desc is <value expr="clientDesc"/></log>
      <log> Management company ID is <value expr="mgmtCmpyId"/></log>

      <!-- ✅ SESSION ID LOG (MATCHING STYLE) -->
      <log> HTTP Session ID is <value expr="httpSessionId"/></log>

      <!-- OPTIONAL FALLBACK -->
      <log> Session ID (fallback) is <value expr="session.connection.callid"/></log>

    </block>
  </form>

</vxml>
