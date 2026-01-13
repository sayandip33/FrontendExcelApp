<form id="askPinForm">
<block>
<log>changePin.jsp: Inside askPin form ... </log>
<log><value expr="pageName"/> BEGIN</log>
<assign name="noinputNomatchCount" expr="0" />
<log><value expr="pageName"/> pinMinLength=<value expr="'${BROKER_MINLENGTH}'"/></log>
<log><value expr="pageName"/> pinMaxLength=<value expr="'${BROKER_MAXLENGTH}'"/></log>
<log><value expr="pageName"/> pinLength=<value expr="'${BROKER_LENGTH}'"/></log>
</block>