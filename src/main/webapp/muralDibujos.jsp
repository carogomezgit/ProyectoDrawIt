<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
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
    <style>
        .card-img-top {
            height: 250px;
            object-fit: cover;
        }
    </style>
</head>

<body class="d-flex flex-column h-100">

    <jsp:include page="header.jsp" />

    <main class="container flex-fill mt-5 pt-4">
         <h1>Mural de Dibujos</h1>
         <p>Aquí se encuentran todos las creaciones de la comunidad</p>

        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-4">

            <% for(Dibujo d : listaDibujos) { %>

            <div class="col d-flex">

                <div class="card shadow-sm h-100">

                    <img src="<%=d.getImagen() %>"
                         class="card-img-top"
                         alt="<%=d.getTitulo()%>">

                    <div class="card-body d-flex flex-column">

                        <h5 class="card-title"><%=d.getTitulo() %></h5>

                        <p class="card-text text-muted small">
                            Por:
                            <%
                             if (d.getUsuario() != null) {
                                out.print(d.getUsuario().getNombre() + " " + d.getUsuario().getApellido());
                             } else {
                                out.print("<span class='text-danger'>Usuario no encontrado</span>");
                             }
                            %>
                        </p>

                        <p class="card-text mt-auto pt-2">
                            <span class="badge bg-primary"><%=d.getTematica() %></span>
                        </p>
                    </div>

                    <d:if test="${rolUsuario == 'ADMINISTRADOR'}">
                        <div class="card-footer d-flex justify-content-center gap-2">

                            <a href="formDibujo.jsp?operacion=editar&id=<%=d.getIdDibujo() %>"
                               class="btn btn-sm btn-warning">Editar</a>

                            <form action="seDibujo" method="POST"
                                  onsubmit="return confirm('¿Estás seguro de que deseas eliminar este dibujo?');"
                                  class="d-inline">
                                <input type="hidden" name="operacion" value="eliminar" />
                                <input type="hidden" name="id" value="<%=d.getIdDibujo() %>" />
                                <button type="submit" class="btn btn-sm btn-danger">Borrar</button>
                            </form>
                        </div>
                    </d:if>
                </div> </div> <% } %> </div> </main>
    <jsp:include page="footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>