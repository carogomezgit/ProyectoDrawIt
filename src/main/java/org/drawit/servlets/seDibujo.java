package org.drawit.servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.drawit.dao.DibujoImpl;
import org.drawit.dao.UsuarioImpl;
import org.drawit.entities.Dibujo;
import org.drawit.entities.Usuario;
import org.drawit.entities.Tematica;

import java.io.IOException;
import java.util.Date;

public class seDibujo extends HttpServlet {

  @Override
  public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
    req.setAttribute("mensaje", "Hola desde el Servlet de DrawIt!");
    req.setAttribute("fecha", new Date());

    String operacion = "nuevo";
    String titulo = "";
    Usuario usuario = null;
    Tematica tematica = null;
    String imagen = "";
    int id = -1;

    // crear usuario en UsuarioImpl, llamar al metodo getbyid

    operacion = req.getParameter("operacion");

    if (operacion.equals("editar") || operacion.equals("nuevo")) {
      titulo = req.getParameter("txtTitulo");
      usuario = new UsuarioImpl().getById(Integer.valueOf(req.getParameter("txtUsuario")));
      tematica = Tematica.valueOf(req.getParameter("lstTematica"));
      imagen = req.getParameter("txtImagen");
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
    DibujoImpl dibujoDAO = new DibujoImpl();
    if (operacion.equals("nuevo")) { // si es nuevo
      Dibujo dibujoNuevo = new Dibujo(id, titulo, usuario, tematica, imagen);
      dibujoDAO.insert(dibujoNuevo);
    }

    // para editar el cliente
    if (operacion.equals("editar")) { // si es editar
      Dibujo dibujoEditar = dibujoDAO.getById(id);
      dibujoEditar.setTitulo(titulo);
      dibujoEditar.setUsuario(usuario);
      dibujoEditar.setTematica(tematica);
      dibujoEditar.setImagen(imagen);
      dibujoDAO.update(dibujoEditar);
    }

    // para borrar el cliente
    if (operacion.equals("eliminar")) { // si es borrar
      dibujoDAO.delete(id);
    }

    RequestDispatcher rd = req.getRequestDispatcher("/index.jsp");
    rd.forward(req, res);
  }
}