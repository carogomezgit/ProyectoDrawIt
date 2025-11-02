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
  public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
    req.setAttribute("mensaje", "Hola desde el Servlet de DrawIt!");
    req.setAttribute("fecha", new Date());

    String operacion = "nuevo";
    String nombre = "";
    String apellido = "";
    String correo = "";
    String clave = "";
    TipoUsuario tipo = null;
    int idUsuario = -1;

    operacion = req.getParameter("operacion");

    if (operacion.equals("editar") || operacion.equals("nuevo")) {
      nombre = req.getParameter("txtNombre");
      apellido = req.getParameter("txtApellido");
      correo = req.getParameter("txtCorreo");
      clave = req.getParameter("txtClave");
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

      if (usuarioDAO.existsByCorreo(correo)) {
        System.out.println("El correo ya se encuentra registrado");
        req.setAttribute("error", "El correo " + correo + " ya se encuentra registrado");
        RequestDispatcher rd = req.getRequestDispatcher("/formRegistro.jsp");
        rd.forward(req, res);
        return;
      } else {
        String claveHasheada = org.drawit.util.PasswordUtil.hashPassword(clave);
        Usuario usuarioNuevo = new Usuario(idUsuario, nombre, apellido, correo, claveHasheada, tipo);
        usuarioDAO.insert(usuarioNuevo);

        req.setAttribute("mensajeExito", "¡Te has registrado correctamente! Ahora puedes iniciar sesión.");

        RequestDispatcher rd = req.getRequestDispatcher("/formLogin.jsp");
        rd.forward(req, res);
        return;
      }
    }

    // para editar el cliente
    if (operacion.equals("editar")) { // si es editar
      Usuario usuarioEditar = usuarioDAO.getById(idUsuario);
      usuarioEditar.setNombre(nombre);
      usuarioEditar.setApellido(apellido);
      usuarioEditar.setCorreo(correo);
      usuarioEditar.setClave(clave);
      usuarioEditar.setTipo(tipo);
      usuarioDAO.update(usuarioEditar);
    }

    // para borrar el cliente
    if (operacion.equals("eliminar")) { // si es borrar
      usuarioDAO.delete(idUsuario);
    }

    res.sendRedirect("listadoUsuario.jsp");
  }


}