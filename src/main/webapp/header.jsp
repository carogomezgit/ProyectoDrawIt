<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="usuario" value="${sessionScope.usuario}" />
<c:set var="rolUsuario" value="${not empty usuario ? usuario.tipo : 'INVITADO'}" />

<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container-fluid">

        <a class="navbar-brand" href="${pageContext.request.contextPath}/index.jsp">DrawIt!</a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/muralDibujos.jsp">Mural</a>
                </li>

                <c:if test="${rolUsuario == 'ADMINISTRADOR'}">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/listadoUsuario.jsp">Usuarios</a>
                    </li>
                </c:if>

                <c:if test="${not empty usuario}">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/formDibujo.jsp">Subir Dibujo</a>
                    </li>
                </c:if>
            </ul>

            <div class="d-flex align-items-center gap-2">
                <c:choose>
                    <c:when test="${empty usuario}">
                        <a href="${pageContext.request.contextPath}/formRegistro.jsp" class="btn btn-outline-primary btn-sm">Registrarse</a>
                        <a href="${pageContext.request.contextPath}/formLogin.jsp" class="btn btn-outline-success btn-sm">Ingresar</a>
                    </c:when>
                    <c:otherwise>
                        <span class="navbar-text text-white">
                            Hola, ${usuario.nombre}
                            <c:if test="${rolUsuario == 'ADMINISTRADOR'}">
                                <span class="badge bg-danger">Admin</span>
                            </c:if>
                        </span>
                        <a href="seSesion?cerrarSesion=true" class="btn btn-outline-danger btn-sm">Cerrar Sesión</a>
                    </c:otherwise>
                </c:choose>
            </div>

        </div>
    </div>
</nav>