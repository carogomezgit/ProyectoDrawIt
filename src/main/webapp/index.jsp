<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!doctype html>
<html lang="es" class="h-100">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>DrawIt! | Inicio</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
  </head>

<body class="d-flex flex-column h-100">
    <jsp:include page="header.jsp" />
    <main class="container flex-fill mt-5 pt-4">

        <c:if test="${not empty mensajeExito}">
            <div class="alert alert-success text-dark" role="alert">
                ${mensajeExito}
            </div>
        </c:if>
            <div class="text-center p-5 rounded-3">
                <h1 class="display-4">¡Bienvenido a DrawIt!</h1>
                <p class="lead">Explorá el mural para ver las creaciones de otros artistas o subí la tuya</p>
            <hr class="my-4">
                <a class="btn btn-primary btn-lg" href="muralDibujos.jsp" role="button">Ver el Mural</a>
                <a class="btn btn-primary btn-lg" href="formDibujo.jsp" role="button">Subir un Dibujo</a>
        </div>
    </main>
    <%@ include file="footer.jsp" %>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
  </body>
</body>
</html>