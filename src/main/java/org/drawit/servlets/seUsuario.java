package org.drawit.servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.drawit.dao.UsuarioImpl;
import org.drawit.entities.Usuario;
import org.drawit.entities.TipoUsuario;

import java.io.IOException;
import java.util.Date;

public class seUsuario extends HttpServlet {

  @Override
  public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
    req.setAttribute("mensaje", "Hola desde el Servlet de DrawIt!");
    req.setAttribute("fecha", new Date());

    String operacion = "nuevo";
    String nombre = "";
    String apellido = "";
    String correo = "";
    TipoUsuario tipo = null;
    int id = -1;

    operacion = req.getParameter("operacion");

    if (operacion.equals("editar") || operacion.equals("nuevo")) {
      nombre = req.getParameter("txtNombre");
      apellido = req.getParameter("txtApellido");
      correo = req.getParameter("txtCorreo");
      tipo = TipoUsuario.valueOf(req.getParameter("txtTipo"));
      id = Integer.parseInt(req.getParameter("txtId"));
    }
    else {
      if (req.getParameter("id")!=null){
        id = Integer.parseInt(req.getParameter("id"));
      }
      else
        id=-1;
    }

    // para guardar el cliente
    UsuarioImpl usuarioDAO = new UsuarioImpl();
    if (operacion.equals("nuevo")) { // si es nuevo
      Usuario usuarioNuevo = new Usuario(id, nombre, apellido, correo, tipo);
      usuarioDAO.insert(usuarioNuevo);
    }

    // para editar el cliente
    if (operacion.equals("editar")) { // si es editar
      Usuario usuarioEditar = usuarioDAO.getById(id);
      usuarioEditar.setNombre(nombre);
      usuarioEditar.setApellido(apellido);
      usuarioEditar.setCorreo(correo);
      usuarioEditar.setTipo(tipo);
      usuarioDAO.update(usuarioEditar);
    }

    // para borrar el cliente
    if (operacion.equals("eliminar")) { // si es borrar
      usuarioDAO.delete(id);
    }

    RequestDispatcher rd = req.getRequestDispatcher("/index.jsp");
    rd.forward(req, res);
  }
}