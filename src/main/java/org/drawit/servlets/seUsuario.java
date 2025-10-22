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
    int idUsuario = -1;

    operacion = req.getParameter("operacion");

    if (operacion.equals("editar") || operacion.equals("nuevo")) {
      nombre = req.getParameter("txtNombre");
      apellido = req.getParameter("txtApellido");
      correo = req.getParameter("txtCorreo");
      tipo = TipoUsuario.valueOf(req.getParameter("lstTipo"));
      idUsuario = Integer.parseInt(req.getParameter("txtIdUsuario"));
    }
    else {
      if (req.getParameter("id")!=null){
        idUsuario = Integer.parseInt(req.getParameter("id"));
      }
      else
        idUsuario =-1;
    }

    // para guardar el cliente
    UsuarioImpl usuarioDAO = new UsuarioImpl();
    if (operacion.equals("nuevo")) { // si es nuevo
      Usuario usuarioNuevo = new Usuario(idUsuario, nombre, apellido, correo, tipo);
      usuarioDAO.insert(usuarioNuevo);
    }

    // para editar el cliente
    if (operacion.equals("editar")) { // si es editar
      Usuario usuarioEditar = usuarioDAO.getById(idUsuario);
      usuarioEditar.setNombre(nombre);
      usuarioEditar.setApellido(apellido);
      usuarioEditar.setCorreo(correo);
      usuarioEditar.setTipo(tipo);
      usuarioDAO.update(usuarioEditar);
    }

    // para borrar el cliente
    if (operacion.equals("eliminar")) { // si es borrar
      usuarioDAO.delete(idUsuario);
    }

    RequestDispatcher rd = req.getRequestDispatcher("/index.jsp");
    rd.forward(req, res);
  }
}