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
    <c:when test="${param.operacion == 'editar'}" > <c:set var="tituloPagina" value="Editar Usuario" /> </c:when>
    <c:when test="${param.operacion == 'eliminar'}" > <c:set var="tituloPagina" value="Eliminar Usuario" /> </c:when>
    <c:otherwise> <c:set var="tituloPagina" value="Nuevo Usuario" /> </c:otherwise>
</c:choose>

<c:set var="isReadOnly" value="${param.operacion == 'eliminar'}" />

<c:choose>
    <c:when test="${isReadOnly}">
        <c:set var="btnText" value="Confirmar Eliminación" />
        <c:set var="btnClass" value="btn-danger" />
    </c:when>
    <c:when test="${param.operacion == 'editar'}">
        <c:set var="btnText" value="Guardar Cambios" />
        <c:set var="btnClass" value="btn-primary" />
    </c:when>
    <c:otherwise>
        <c:set var="btnText" value="Registrarse" />
        <c:set var="btnClass" value="btn-primary" />
    </c:otherwise>
</c:choose>

<!doctype html>
<html lang="es" class="h-100">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>DrawIt! | ${tituloPagina}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
</head>

<body class="d-flex flex-column h-100">

    <jsp:include page="header.jsp" />

    <main class="container flex-fill mt-5 pt-4">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <div class="card shadow-sm">
                    <div class="card-body p-4 p-md-5">

                        <h2 class="card-title text-center h3 mb-4">${tituloPagina}</h2>

                        <c:if test="${not empty error}">
                            <div class="alert alert-danger" role="alert">
                                ${error}
                            </div>
                        </c:if>

                        <form action="seUsuario" method="GET">

                            <input type="hidden" name="txtIdUsuario" id="txtIdUsuario"
                                value="${not empty usuarioEditar.idUsuario ? usuarioEditar.idUsuario : -1}"
                            />

                            <input type="hidden" name="operacion" id="operacion"
                                value="${not empty param.operacion ? param.operacion : 'nuevo' }"
                            />

                            <c:if test="${param.operacion == 'editar'}">
                                <div class="mb-3">
                                    <label for="lstUsuario" class="form-label">Administrar Usuario</label>
                                    <select name="lstUsuario" id="lstUsuario" class="form-select">
                                        <c:forEach var="usr" items="${listaUsuario}">
                                            <option value="${usr.idUsuario}"
                                                <c:if test="${usuarioEditar.idUsuario == usr.idUsuario}">selected</c:if>>
                                                ${usr.nombre} ${usr.apellido}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </c:if>
                            <div class="mb-3">
                                <label for="txtNombre" class="form-label">Nombre</label>
                                <input type="text" name="txtNombre" id="txtNombre" class="form-control"
                                    placeholder="Nombre"
                                    value="${not empty usuarioEditar.nombre ? usuarioEditar.nombre : ''}"
                                    ${isReadOnly ? 'readonly' : ''}
                                    required />
                            </div>
                            <div class="mb-3">
                                <label for="txtApellido" class="form-label">Apellido</label>
                                <input type="text" name="txtApellido" id="txtApellido" class="form-control"
                                    placeholder="Apellido"
                                    value="${not empty usuarioEditar.apellido ? usuarioEditar.apellido : ''}"
                                    ${isReadOnly ? 'readonly' : ''}
                                    required />
                            </div>
                            <div class="mb-3">
                                <label for="txtCorreo" class="form-label">Correo Electrónico</label>
                                <input type="email" name="txtCorreo" id="txtCorreo" class="form-control"
                                    placeholder="usuario@ejemplo.com"
                                    value="${not empty usuarioEditar.correo ? usuarioEditar.correo : ''}"
                                    ${isReadOnly ? 'readonly' : ''}
                                    required />
                            </div>
                            <div class="mb-3">
                                <label for="txtContraseña" class="form-label">Contraseña</label>
                                <input type="text" name="txtContraseña" id="txtContraseña" class="form-control"
                                placeholder="Contraseña"
                                value="${not empty usuarioEditar.contrasenia ? usuarioEditar.contrasenia : ''}"
                                ${isReadOnly ? 'readonly' : ''}
                                required />
                            </div>
                            <div class="mb-3">
                                <label for="lstTipo" class="form-label">Tipo de Usuario</label>
                                <select name="lstTipo" id="lstTipo" class="form-select"
                                    ${isReadOnly ? 'disabled' : ''}
                                    required>
                                    <c:forEach var="tipo" items="${listaTipoUsuarios}">
                                        <option value="${tipo.name()}"
                                            <c:if test="${usuarioEditar.tipo == tipo}">selected</c:if>>
                                            ${tipo.name()}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="d-grid mt-4">
                                <input type="submit"
                                value="${btnText}"
                                class="btn ${btnClass} btn-lg" />
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <jsp:include page="footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>