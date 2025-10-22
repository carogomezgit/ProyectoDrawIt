<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %> .
<%@ taglib prefix="d" uri="jakarta.tags.core" %>

<%@ page import="org.drawit.dao.DibujoImpl" %>
<%@ page import="org.drawit.entities.Dibujo" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>

<%!
    DibujoImpl dibujoDao = new DibujoImpl();
    Dibujo dibujo = new Dibujo();
    List<Dibujo> listaDibujos = dibujoDao.getAll();
%>

<html>
    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Imagen</th>
            <th>Titulo</th>
            <th>Autor</th>
            <th>Temática</th>
            <th>Editar</th>
            <th>Borrar</th>
        </tr>
        </thead>
        <tbody>

        <tr>
        <% for(Dibujo d : listaDibujos) { %>
            <td> <%=d.getIdDibujo() %> </td>
            <td> <%=d.getImagen() %></td>
            <td> <%=d.getTitulo() %> </td>
            <td> <%=d.getUsuario().getNombre() %> <%=d.getUsuario().getApellido() %> </td>
            <td> <%=d.getTematica() %> </td>
            <td> <a href="formDibujo.jsp?operacion=editar&id=<%=d.getIdDibujo() %>">Editar</a></td>
            <td> <a href="seDibujo?operacion=eliminar&id=<%=d.getIdDibujo() %>">Borrar</a></td>
            </tr>
        <% } %>
        </tbody>
    </table>
</html>