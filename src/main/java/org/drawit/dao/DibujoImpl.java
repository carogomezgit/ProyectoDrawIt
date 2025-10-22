package org.drawit.dao;

import org.drawit.entities.Dibujo;
import org.drawit.entities.Tematica;
import org.drawit.interfaces.AdmConexion;
import org.drawit.interfaces.DAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DibujoImpl implements DAO<Dibujo, Integer>, AdmConexion {
  private Connection conn = null;

  private static final String SQL_INSERT =
      "INSERT INTO dibujo (titulo, idUsuario, tematica, imagen) " +
          "VALUES (?, ?, ?, ?)";

  private static final String SQL_UPDATE =
      "UPDATE dibujo SET " +
          "titulo = ? , idUsuario = ? , tematica = ? , imagen = ? " +
          "WHERE idDibujo = ?";

  private static final String SQL_DELETE = "DELETE FROM dibujo WHERE idDibujo = ?";
  private static final String SQL_GETALL =
      "SELECT * FROM dibujo ORDER BY titulo";
  private static final String SQL_GETBYID = "SELECT * FROM dibujo WHERE idDibujo = ? ";


  @Override
  public List<Dibujo> getAll() {
    conn = obtenerConexion();

    PreparedStatement pst = null;
    ResultSet rs = null;

    List<Dibujo> listaDibujos = new ArrayList();

    try {
      pst = conn.prepareStatement(SQL_GETALL);
      rs = pst.executeQuery();

      while (rs.next()) {
        Dibujo dibujo = new Dibujo();
        dibujo.setIdDibujo(rs.getInt("idDibujo"));
        dibujo.setTitulo(rs.getString("titulo"));
        dibujo.setTematica(Tematica.valueOf(rs.getString("tematica")));
        UsuarioImpl daoUser = new UsuarioImpl();
        dibujo.setUsuario(daoUser.getById(rs.getInt("idUsuario")));
        dibujo.setImagen(rs.getString("imagen"));
        listaDibujos.add(dibujo);
      }

      rs.close();
      pst.close();
      conn.close();
    } catch (SQLException e) {
      System.out.println("Error al obtener todos los dibujos");
      throw new RuntimeException(e);
    }
    return listaDibujos;
  }

  @Override
  public void insert(Dibujo objeto) {
    Dibujo dibujo = objeto;
    UsuarioImpl usuarioImpl = new UsuarioImpl();
    boolean existeUsuario = usuarioImpl.existsById(dibujo.getUsuario().getIdUsuario());
    conn = obtenerConexion();

    PreparedStatement pst = null;

    try {
      pst = conn.prepareStatement(SQL_INSERT, Statement.RETURN_GENERATED_KEYS);

      pst.setString(1, dibujo.getTitulo());
      pst.setInt(2, dibujo.getUsuario().getIdUsuario());
      pst.setString(3, dibujo.getTematica().toString());
      pst.setString(4, dibujo.getImagen());

      int resultado = pst.executeUpdate();
      if (resultado == 1) {
        System.out.println("Se ha insertado el dibujo correctamente");
      } else {
        System.out.println("No se pudo insertar el dibujo");
      }
    } catch (SQLException e) {
      throw new RuntimeException(e);
    }
  }

  @Override
  public void update(Dibujo objeto) {
    Dibujo dibujo = objeto;

    if (this.existsById(dibujo.getIdDibujo())) {
      conn = obtenerConexion();
      PreparedStatement pst = null;

      try {
        pst = conn.prepareStatement(SQL_UPDATE);

        pst.setString(1, dibujo.getTitulo());
        pst.setInt(2, dibujo.getUsuario().getIdUsuario());
        pst.setString(3, dibujo.getTematica().toString());
        pst.setString(4, dibujo.getImagen());
        pst.setInt(5, dibujo.getIdDibujo());

        int resultado = pst.executeUpdate();
        if (resultado == 1) {
          System.out.println("Dibujo actualizado correctamente");
        } else {
          System.out.println("No se pudo actualizar el dibujo");
        }

        pst.close();
        conn.close();
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
        System.out.println("Dibujo eliminado");
      } else {
        System.out.println("No se pudo eliminar el dibujo");
      }

      pst.close();
      conn.close();
    } catch (SQLException e) {
      throw new RuntimeException(e);
    }
  }

  @Override
  public Dibujo getById(Integer id) {
    conn = obtenerConexion();

    PreparedStatement pst = null;
    ResultSet rs = null;
    Dibujo dibujo = null;

    try {
      pst = conn.prepareStatement(SQL_GETBYID);

      pst.setInt(1, id);
      rs = pst.executeQuery();

      if (rs.next()) {
        dibujo = new Dibujo();
        dibujo.setIdDibujo(rs.getInt("idDibujo"));
        dibujo.setTitulo(rs.getString("titulo"));
        dibujo.setTematica(Tematica.valueOf(rs.getString("tematica")));
        dibujo.setImagen(rs.getString("imagen"));
        UsuarioImpl daoUser = new UsuarioImpl();
        dibujo.setUsuario(daoUser.getById(rs.getInt("idUsuario")));
      }

      rs.close();
      pst.close();
      conn.close();

    } catch (SQLException e) {
      throw new RuntimeException(e);
    }
    return dibujo;
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