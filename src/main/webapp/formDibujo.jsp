<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="d" uri="jakarta.tags.core" %>

<d:if test="${empty sessionScope.usuario}">
    <d:redirect url="formLogin.jsp?mensajeError=Debes iniciar sesion para subir un dibujo."/>
</d:if>
<%@ page import="org.drawit.entities.Tematica" %>

<jsp:useBean id="dibujo" class="org.drawit.entities.Dibujo" scope="request" />
<jsp:useBean id="dibujoDao" class="org.drawit.dao.DibujoImpl" scope="page" />
<jsp:useBean id="usuarioDao" class="org.drawit.dao.UsuarioImpl" scope="page" />
<d:set var="listaUsuarios" value="${usuarioDao.getAll()}" />

<d:set var="usuario" value="${sessionScope.usuario}" />
<d:set var="rolUsuario" value="${not empty usuario ? usuario.tipo : 'INVITADO'}" />

<d:if test="${param.operacion == 'editar' || param.operacion == 'eliminar'}">
    <d:set var="idDibujo" value="${Integer.parseInt(param.id)}" />
    <d:set var="dibujoEditar" value="${dibujoDao.getById(idDibujo)}" />
    <d:set var="listaDibujos" value="${dibujoDao.getAll()}" />
    <d:set var="listaTematicas" value="${Tematica.values()}" />
</d:if>

<%
    Tematica[] tematicas = Tematica.values();
    request.setAttribute("listaTematicas", tematicas);
%>

<d:choose>
    <d:when test="${param.operacion == 'editar'}" > <d:set var="tituloPagina" value="Editar Dibujo" /> </d:when>
    <d:when test="${param.operacion == 'eliminar'}" > <d:set var="tituloPagina" value="Eliminar Dibujo" /> </d:when>
    <d:otherwise> <d:set var="tituloPagina" value="Nuevo Dibujo" /> </d:otherwise>
</d:choose>

<d:set var="isReadOnly" value="${param.operacion == 'eliminar'}" />

<d:choose>
    <d:when test="${isReadOnly}">
        <d:set var="btnText" value="Confirmar Eliminación" />
        <d:set var="btnClass" value="btn-danger" />
    </d:when>
    <d:when test="${param.operacion == 'editar'}">
        <d:set var="btnText" value="Guardar Cambios" />
        <d:set var="btnClass" value="btn-primary" />
    </d:when>
    <d:otherwise>
        <d:set var="btnText" value="Subir Dibujo" />
        <d:set var="btnClass" value="btn-primary" />
    </d:otherwise>
</d:choose>

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
                         <h1 class="card-title text-center h3 mb-4">${tituloPagina}</h1>

                        <d:if test="${not empty error}">
                            <div class="alert alert-danger" role="alert">
                                ${error}
                            </div>
                        </d:if>

                        <form action="seDibujo" method="POST">

                        <d:if test="${param.operacion == 'editar' && rolUsuario == 'ADMINISTRADOR'}">
                            <div class="mb-3">
                                <label for="selectDibujo" class="form-label">Administrar Dibujo</label>
                                <select name="lstDibujo" id="lstDibujo" tabindex="1" class="form-select">
                                    <d:forEach var="dibujo" items="${listaDibujos}">
                                        <option value="${dibujo.idDibujo}"
                                                  <d:if test="${dibujoEditar.idDibujo == dibujo.idDibujo}">selected</d:if>>
                                            ${dibujo.titulo}
                                        </option>
                                    </d:forEach>
                                </select>
                             </div>
                        </d:if>
                        <br>

                        <input type="hidden" name="txtId" id="txtId"
                           value="${not empty dibujoEditar.idDibujo ? dibujoEditar.idDibujo : -1}"
                        />

                        <input type="hidden" name="operacion" id="operacion"
                            value="${not empty param.operacion ? param.operacion : 'nuevo' }"
                        />

                        <div class="mb-3">
                            <label for="txtTitulo" class="form-label">Título</label>
                            <input type="text" name="txtTitulo" id="txtTitulo" class="form-control"
                            placeholder="Titulo"
                            value="${not empty dibujoEditar.titulo ? dibujoEditar.titulo : ''}"
                            ${isReadOnly ? 'readonly' : ''}
                            required />
                        </div>
                        <br>

                        <d:choose>
                            <d:when test="${rolUsuario == 'ADMINISTRADOR'}">
                                <div class="mb-3">
                                    <label for="txtUsuario" class="form-label">Autor (Modo Admin)</label>
                                    <select name="txtUsuario" id="txtUsuario" class="form-select"
                                            ${isReadOnly ? 'disabled' : ''} required>
                                        <option value="">Seleccione un autor</option>
                                        <d:forEach var="usr" items="${listaUsuarios}">
                                            <option value="${usr.idUsuario}"
                                                <d:if test="${dibujoEditar.usuario.idUsuario == usr.idUsuario}">selected</d:if>>
                                                ${usr.nombre} ${usr.apellido}
                                            </option>
                                        </d:forEach>
                                    </select>
                                </div>
                            </d:when>
                            <d:otherwise>
                                <input type="hidden" name="txtUsuario" value="${usuario.idUsuario}" />
                            </d:otherwise>
                        </d:choose>
                        <br>
                         <div class="mb-3">
                            <label for="lstTematica" class="form-label">Temática</label>
                            <select name="lstTematica" id="lstTematica" class="form-select"
                                 ${isReadOnly ? 'disabled' : ''}
                                required>
                                <option value="">Seleccione una temática</option>
                                <d:forEach var="tematica" items="${listaTematicas}">
                                    <option value="${tematica.name()}"
                                        <d:if test="${dibujoEditar.tematica == tematica}">selected</d:if>>
                                         ${tematica.name()}
                                    </option>
                                </d:forEach>
                             </select>
                        </div>
                        <br>
                        <div class="mb-3">
                             <label for="txtImagen" class="form-label">URL de la Imagen</label>
                            <input type="text" name="txtImagen" id="txtImagen" class="form-control"
                            placeholder="https://drive.google.com/file/d/id_unico..."
                             value="${not empty dibujoEditar.imagen ? dibujoEditar.imagen : ''}"
                            ${isReadOnly ? 'readonly' : ''}
                            required
                            aria-describedby="campoImagen" class="form-text"/>
                             <div id="campoImagen">
                                <em>Solo soporta enlaces de Google Drive</em>
                            </div>
                         </div>
                        <br>
                        <div class="d-grid mt-4">
                            <input type="submit" value="${btnText}" class="btn ${btnClass} btn-lg" />
                         </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
     </main>
    <%@ include file="footer.jsp" %>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
  </body>
</html>