<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %> .
<%@ taglib prefix="d" uri="jakarta.tags.core" %>

<%@ page import="org.drawit.dao.DibujoImpl" %>
<%@ page import="org.drawit.entities.Dibujo" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>

<%
    DibujoImpl dibujoDao = new DibujoImpl();
    List<Dibujo> listaDibujos = dibujoDao.getAll();
%>

<!doctype html>
<html lang="es" class="h-100">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>DrawIt! | Mural de Dibujos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
</head>

<body class="d-flex flex-column h-100">

    <jsp:include page="header.jsp" />

    <main class="container flex-fill mt-5 pt-4">
         <h1>Mural de Dibujos</h1>
         <p>Aquí se encuentran todos las creaciones de la comunidad</p>
    <div class="table-responsive">
         <table class="table table-striped table-hover">
              <thead class="table-dark">
              <tr>
                    <th>Imagen</th>
                    <th>Titulo</th>
                    <th>Autor</th>
                    <th>Temática</th>
                    <th>Administrar</th>
                    <th></th>
              </tr>
              </thead>
              <tbody>
                   <% for(Dibujo d : listaDibujos) { %>
                   <tr>
                        <td><img src="<%=d.getImagen() %>"
                        alt="<%=d.getTitulo()%>"
                        style="width: 250px; height: auto;"> </td>
                        <td> <%=d.getTitulo() %> </td>
                        <td> <%=d.getUsuario().getNombre() %> <%=d.getUsuario().getApellido() %> </td>
                        <td> <%=d.getTematica() %> </td>
                        <d:if test="${rolUsuario == 'ADMINISTRADOR'}">
                             <td> <a href="formDibujo.jsp?operacion=editar&id=<%=d.getIdDibujo() %>">Editar</a></td>
                             <td> <form action="seDibujo" method="POST"
                             onsubmit="return confirm('¿Estás seguro de que deseas eliminar este dibujo?');">
                             <input type="hidden" name="operacion" value="eliminar" />
                             <input type="hidden" name="id" value="<%=d.getIdDibujo() %>" />
                             <button type="submit" class="btn btn-link text-danger p-0">Borrar</button>
                                  </form>
                             </td>
                        </d:if>
                  </tr>
                  <% } %>
                  </tbody>
                  </table>
              </div>
        </main>
        <jsp:include page="footer.jsp" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>