package org.drawit.dao;

import org.drawit.entities.TipoUsuario;
import org.drawit.entities.Usuario;
import org.drawit.interfaces.AdmConexion;
import org.drawit.interfaces.DAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UsuarioImpl implements DAO<Usuario, Integer>, AdmConexion {
  private Connection conn = null;

  private static final String SQL_INSERT =
      "INSERT INTO usuario (nombre, apellido, correo, tipo) " +
          "VALUES (?, ?, ?, ?)";

  private static final String SQL_UPDATE =
      "UPDATE usuario SET " +
          "nombre = ? , apellido = ? , correo = ? , tipo = ? " +
          "WHERE idUsuario = ?";

  private static final String SQL_DELETE = "DELETE FROM usuario WHERE idUsuario = ?";
  private static final String SQL_GETALL =
      "SELECT * FROM usuario ORDER BY apellido";
  private static final String SQL_GETBYID = "SELECT * FROM usuario WHERE idUsuario = ? ";


  @Override
  public List<Usuario> getAll() {

    conn = obtenerConexion();

    PreparedStatement pst = null;
    ResultSet rs = null;

    List<Usuario> listaUsuarios = new ArrayList();

    try {
      pst = conn.prepareStatement(SQL_GETALL);
      rs = pst.executeQuery();

      while (rs.next()) {
        Usuario usuario = new Usuario();
        usuario.setUsuarioId(rs.getInt("idUsuario"));
        usuario.setNombre(rs.getString("nombre"));
        usuario.setApellido(rs.getString("apellido"));
        usuario.setCorreo(rs.getString("correo"));
        usuario.setTipo(TipoUsuario.valueOf(rs.getString("tipo")));

        listaUsuarios.add(usuario);
      }

      rs.close();
      pst.close();
      conn.close();
    } catch (SQLException e) {
      System.out.println("Error al obtener todos los usuarios");
      throw new RuntimeException(e);
    }
    return listaUsuarios;
  }

  @Override
  public void insert(Usuario objeto) {
    Usuario usuario = objeto;
    conn = obtenerConexion();

    PreparedStatement pst = null;

    try {
      pst = conn.prepareStatement(SQL_INSERT, Statement.RETURN_GENERATED_KEYS);

      pst.setString(1, usuario.getNombre());
      pst.setString(2, usuario.getApellido());
      pst.setString(3, usuario.getCorreo());
      pst.setString(4, usuario.getTipo().toString());

      int resultado = pst.executeUpdate();
      if (resultado == 1) {
        System.out.println("Usuario insertado correctamente");
      } else {
        System.out.println("No se pudo agregar el usuario");
      }
    } catch (SQLException e) {
      throw new RuntimeException(e);
    }
  }

  @Override
  public void update(Usuario objeto) {
    Usuario usuario = objeto;

    if (this.existsById(usuario.getIdUsuario())) {
      conn = obtenerConexion();
      PreparedStatement pst = null;

      try {
        pst = conn.prepareStatement(SQL_UPDATE);

        pst.setString(1, usuario.getNombre());
        pst.setString(2, usuario.getApellido());
        pst.setString(3, usuario.getCorreo());
        pst.setString(4, usuario.getTipo().toString());
        pst.setInt(5, usuario.getIdUsuario());

        int resultado = pst.executeUpdate();
        if (resultado == 1) {
          System.out.println("Usuario actualizado correctamente");
        } else {
          System.out.println("No se pudo actualizar el usuario");
        }
      } catch (SQLException e) {
        throw new RuntimeException(e);
      }
    }
  }

  @Override
  public void delete(Integer id) {
    conn = obtenerConexion();

    PreparedStatement pst = null;
    try {
      pst = conn.prepareStatement(SQL_DELETE);

      pst.setInt(1, id);

      int resultado = pst.executeUpdate();
      if (resultado == 1) {
        System.out.println("Usuario eliminado");
      } else {
        System.out.println("No se pudo eliminar el usuario");
      }

      pst.close();
      conn.close();

    } catch (SQLException e) {
      throw new RuntimeException(e);
    }

  }

  @Override
  public Usuario getById(Integer id) {
    conn = obtenerConexion();

    PreparedStatement pst = null;
    ResultSet rs = null;
    Usuario usuario = null;

    try {
      pst = conn.prepareStatement(SQL_GETBYID);
      pst.setInt(1, id);
      rs = pst.executeQuery();

      if (rs.next()) {
        usuario = new Usuario();
        usuario.setUsuarioId(rs.getInt("idUsuario"));
        usuario.setNombre(rs.getString("nombre"));
        usuario.setApellido(rs.getString("apellido"));
        usuario.setCorreo(rs.getString("correo"));
        usuario.setTipo(TipoUsuario.valueOf(rs.getString("tipo")));
      }

      rs.close();
      pst.close();
      conn.close();
    } catch (SQLException e) {
      throw new RuntimeException(e);
    }

    return usuario;
  }

  @Override
  public boolean existsById(Integer id) {
    conn = obtenerConexion();

    PreparedStatement pst = null;
    ResultSet rs = null;
    boolean existe = false;

    try {
      pst = conn.prepareStatement(SQL_GETBYID);
      pst.setInt(1, id);
      rs = pst.executeQuery();

      if (rs.next()) {
        existe = true;
      }
    } catch (SQLException e) {
      throw new RuntimeException(e);
    }

    return existe;
  }
}