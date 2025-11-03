<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%@ page import="org.drawit.dao.UsuarioImpl" %>
<%@ page import="org.drawit.entities.Usuario" %>
<%@ page import="java.util.List" %>

<c:set var="usuario" value="${sessionScope.usuario}" />
<c:set var="rolUsuario" value="${not empty usuario ? usuario.tipo : 'INVITADO'}" />

<c:if test="${rolUsuario != 'ADMINISTRADOR'}">
    <c:url var="loginUrl" value="formLogin.jsp">
            <c:param name="mensajeError" value="No tienes permisos para acceder a esta página."/>
        </c:url>
        <c:redirect url="${loginUrl}"/>
</c:if>

<%
    UsuarioImpl usuarioDao = new UsuarioImpl();
    List<Usuario> listaUsuarios = usuarioDao.getAll();
%>

<!doctype html>
<html lang="es" class="h-100">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>DrawIt! | Usuarios Registrados</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
</head>

<body class="d-flex flex-column h-100">

    <jsp:include page="header.jsp" />

    <main class="container flex-fill mt-5 pt-4">
         <h1>Usuarios Registrados</h1>
         <p>Aquí se encuentran todos los usuarios registrados en DrawIt!</p>
    <div class="table-responsive">
        <table class="table table-striped table-hover">
            <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Nombre</th>
                <th>Apellido</th>
                <th>Correo</th>
                <th>Tipo de Usuario</th>
                <th>Editar</th>
                <th>Borrar</th>
            </tr>
            </thead>
            <tbody>

                <% for(Usuario u : listaUsuarios) { %>
                <tr>
                    <td> <%=u.getIdUsuario() %> </td>
                    <td> <%=u.getNombre() %></td>
                    <td> <%=u.getApellido() %> </td>
                    <td> <%=u.getCorreo() %> </td>
                    <td> <%=u.getTipo() %> </td>
                    <td> <a href="formRegistro.jsp?operacion=editar&id=<%=u.getIdUsuario() %>">Editar</a></td>
                    <td> <form action="seUsuario" method="POST"
                         onsubmit="return confirm('¿Estás seguro de que deseas eliminar este usuario?');">
                         <input type="hidden" name="operacion" value="eliminar" />
                         <input type="hidden" name="id" value="<%=u.getIdUsuario() %>" />
                         <button type="submit" class="btn btn-link text-danger p-0">Borrar</button>
                         </form>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
    </main>
    <jsp:include page="footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</html>