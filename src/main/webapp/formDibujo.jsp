<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %> .
<%@ taglib prefix="d" uri="jakarta.tags.core" %>

<%@ page import="org.drawit.entities.Tematica" %>

<jsp:useBean id="dibujo" class="org.drawit.entities.Dibujo" scope="request" />
<jsp:useBean id="dibujoDao" class="org.drawit.dao.DibujoImpl" scope="page" />
<jsp:useBean id="usuarioDao" class="org.drawit.dao.UsuarioImpl" scope="page" />
<d:set var="listaUsuarios" value="${usuarioDao.getAll()}" />

<d:if test="${param.operacion == 'editar'}">
    <d:set var="idDibujo" value="${Integer.parseInt(param.id)}" />
    <d:set var="dibujoEditar" value="${dibujoDao.getById(idDibujo)}" />
    <d:set var="listaDibujos" value="${dibujoDao.getAll()}" />
    <d:set var="listaTematicas" value="${Tematica.values()}" />
</d:if>

<%
    Tematica[] tematicas = Tematica.values();
    request.setAttribute("listaTematicas", tematicas);
%>

<h2>
<d:choose>
    <d:when test="${param.operacion == 'editar'}" > Editar Dibujo </d:when>
    <d:when test="${param.operacion == 'eliminar'}" > Eliminar Dibujo </d:when>
    <d:otherwise> Nuevo Dibujo </d:otherwise>
</d:choose>
</h2>

<html>

<form action="seDibujo" method="GET">

<label for="selectDibujo">Seleccionar Dibujo</label>
<select name="lstDibujo" id="lstDibujo" tabindex="1">
    <d:forEach var="dibujo" items="${listaDibujos}">
        <option value="${dibujo.idDibujo}"
            <d:if test="${dibujoEditar.idDibujo == dibujo.idDibujo}">selected</d:if>>
            ${dibujo.titulo}
            </option>
        </d:forEach>
    </select>
<br>

<input type="hidden" name="txtId" id="txtId"
    value="${not empty dibujoEditar.idDibujo ? dibujoEditar.idDibujo : -1}"
/>

<input type="hidden" name="operacion" id="operacion"
    value="${param.operacion =='editar' ? 'editar' : 'nuevo' }"
    />

<label for="txtTitulo"> Titulo </label>
<input type="text" name="txtTitulo" id="txtTitulo" placeholder="Título"
    value="${ not empty dibujoEditar.titulo ? dibujoEditar.titulo : '' }"
required />
<br>
<label for="txtUsuario"> Autor </label>
<select name="txtUsuario" id="txtUsuario" required>
    <option value="">Seleccione un autor</option>
    <d:forEach var="usr" items="${listaUsuarios}">
        <option value="${usr.idUsuario}"
            <d:if test="${dibujoEditar.usuario.idUsuario == usr.idUsuario}">selected</d:if>
        >
            ${usr.nombre} ${usr.apellido}
        </option>
    </d:forEach>
</select>
<br>
<label for="txtTematica"> Tematica </label>
<select name="lstTematica" id="lstTematica" tabindex="1">
        <d:forEach var="tematica" items="${listaTematicas}">
            <option value="${tematica.name()}">
                ${tematica.name()}
            </option>
        </d:forEach>
</select>
<br>
<label for="txtImagen"> Imagen </label>
<input type="text" name="txtImagen" id="txtImagen" placeholder="Url de imagen"
    value="${ not empty dibujoEditar.imagen ? dibujoEditar.imagen : '' }"
required />
<br>
<input type="submit" value="Enviar" />

</form>
</html>