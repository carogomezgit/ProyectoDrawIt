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
         <h2>Mural de Dibujos</h2>
    <div class="table-responsive">
         <table class="table table-striped table-hover">
              <thead class="table-dark">
              <tr>
                    <th>Imagen</th>
                    <th>Titulo</th>
                    <th>Autor</th>
                    <th>Temática</th>
                    <th>Administrar</th>
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
                        <td> <a href="formDibujo.jsp?operacion=editar&id=<%=d.getIdDibujo() %>">Editar</a></td>
                        <td> <a href="seDibujo?operacion=eliminar&id=<%=d.getIdDibujo() %>">Borrar</a></td>
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