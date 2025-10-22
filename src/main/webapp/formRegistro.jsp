<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %> .
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%@ page import="org.drawit.entities.TipoUsuario" %>

<jsp:useBean id="usuario" class="org.drawit.entities.Usuario" scope="request" />
<jsp:useBean id="usuarioDao" class="org.drawit.dao.UsuarioImpl" scope="page" />

<c:if test="${param.operacion == 'editar'}">
    <c:set var="idUsuario" value="${Integer.parseInt(param.id)}" />
    <c:set var="usuarioEditar" value="${usuarioDao.getById(idUsuario)}" />
    <c:set var="listaUsuario" value="${usuarioDao.getAll()}" />
    <c:set var="listaTipoUsuarios" value="${TipoUsuario.values()}" />
</c:if>

<%
    TipoUsuario[] tipos = TipoUsuario.values();
    request.setAttribute("listaTipoUsuarios", tipos);
%>

<c:choose>
    <c:when test="${param.operacion == 'editar'}" > Editar Usuario </c:when>
    <c:when test="${param.operacion == 'eliminar'}" > Eliminar Usuario </c:when>
    <c:otherwise> Nuevo Usuario </c:otherwise>
</c:choose>

<html>

<form action="seUsuario" method="GET">

<label for="selectUsuario">Seleccionar Usuario</label>
<select name="lstUsuario" id="lstUsuario" tabindex="1">
    <c:forEach var="usr" items="${listaUsuarios}">
        <option value="${usr.id}"
            <c:if test="${usuarioEditar.idUsuario == usr.id}">selected</c:if>>
            ${usr.nombre} ${usr.apellido}
            </option>
        </c:forEach>
    </select>
<br>

<input type="hidden" name="txtIdUsuario" id="txtIdUsuario"
    value="${not empty usuarioEditar.id ? usuarioEditar.idUsuario : -1}"
/>

<input type="hidden" name="operacion" id="operacion"
    value="${param.operacion =='editar' ? 'editar' : 'nuevo' }"
    />

<label for="txtNombre"> Nombre </label>
<input type="text" name="txtNombre" id="txtNombre" placeholder="Nombre"
    value="${ not empty usuarioEditar.nombre ? usuarioEditar.nombre : '' }"
required />
<br>
<label for="txtApellido"> Apellido </label>
<input type="text" name="txtApellido" id="txtApellido" placeholder="Apellido"
    value="${ not empty usuarioEditar.apellido ? usuarioEditar.apellido : '' }"
required />
<br>
<label for="txtCorreo"> Correo </label>
<input type="text" name="txtCorreo" id="txtCorreo" placeholder="Correo"
    value="${ not empty usuarioEditar.correo ? usuarioEditar.correo : '' }"
required />
<br>
<label for="txtTipo"> Tipo </label>
<select name="lstTipo" id="lstTipo" tabindex="1">
        <c:forEach var="tipo" items="${listaTipoUsuarios}">
            <option value="${tipo.name()}">
                ${tipo.name()}
            </option>
        </c:forEach>
</select>
<br>


<input type="submit" value="Enviar" />

</form>
</html>