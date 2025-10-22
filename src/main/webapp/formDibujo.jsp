<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %> .
<%@ taglib prefix="d" uri="jakarta.tags.core" %>

<jsp:useBean id="dibujo" class="org.drawit.entities.Dibujo" scope="request" />
<jsp:useBean id="dibujoDao" class="org.drawit.dao.DibujoImpl" scope="page" />

<c:if test="${param.operacion == 'editar'}">
    <c:set var="idDibujo" value="${Integer.parseInt(param.id)}" />
    <c:set var="dibujoEditar" value="${dibujoDao.getById(idDibujo)}" />
    <c:set var="listaDibujos" value="${dibujoDao.getAll()}" />
    <c:set var="listaTematicas" value="${Tematica.values()}" />
</c:if>

<%
    Tematica[] tipos = Tematica.values();
    request.setAttribute("listaTematicas", tipos);
%>

<h2>
<c:choose>
    <c:when test="${param.operacion == 'editar'}" > Editar Dibujo </c:when>
    <c:when test="${param.operacion == 'eliminar'}" > Eliminar Dibujo </c:when>
    <c:otherwise> Nuevo Dibujo </c:otherwise>
</c:choose>
</h2>

<html>

<form action="seDibujo" method="GET">

<label for="selectDibujo">Seleccionar Dibujo</label>
<select name="lstDibujo" id="lstDibujo" tabindex="1">
    <c:forEach var="dibujo" items="${listaDibujos}">
        <option value="${dibujo.idDibujo}"
            <c:if test="${dibujoEditar.idDibujo == dibujo.idDibujo}">selected</c:if>>
            ${dibujo.titulo}
            </option>
        </c:forEach>
    </select>
<br>

<input type="hidden" name="txtId" id="txtId"
    value="${not empty dibujoEditar.idDibujo ? dibujoEditar.idDibujo : -1}"
/>

<input type="hidden" name="operacion" id="operacion"
    value="${param.operacion =='editar' ? 'editar' : 'nuevo' }"
    />

<label for="txtTitulo"> Titulo </label>
<input type="text" name="txtNombre" id="txtNombre" placeholder="Nombre"
    value="${ not empty dibujoEditar.titulo ? dibujoEditar.titulo : '' }"
required />
<br>
<label for="txtUsuario"> Autor </label>
<input type="text" name="txtApellido" id="txtApellido" placeholder="Apellido"
    value="${ not empty usuarioEditar.apellido ? usuarioEditar.apellido : '' }"
required />
<br>
<label for="txtTematica"> Temática </label>
<input type="text" name="txtTematica" id="txtTematica" placeholder="Temática"
    value="${ not empty dibujoEditar.tematica ? dibujoEditar.tematica : '' }"
required />
<br>
<label for="txtTipo"> Tipo </label>
<input type="text" name="txtTipo" id="txtTipo" placeholder="Tipo"
    value="${ not empty usuarioEditar.tipo ? usuarioEditar.tipo : '' }"
required />
<br>
<input type="submit" value="Enviar" />

</form>
</html>