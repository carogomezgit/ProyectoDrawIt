package org.drawit.entities;

import java.util.Objects;

public class Dibujo implements Comparable{
  private int idDibujo;
  private String titulo;
  private Usuario usuario;
  private Tematica tematica;

  public Dibujo (){
  }

  public Dibujo (String titulo, Usuario usuario, Tematica tematica){
    this.titulo = titulo;
    this.usuario = usuario;
    this.tematica = tematica;
  }

  public int getIdDibujo() {
    return idDibujo;
  }

  public void setIdDibujo(int idDibujo) {
    this.idDibujo = idDibujo;
  }

  public String getTitulo() {
    return titulo;
  }

  public void setTitulo(String titulo) {
    this.titulo = titulo;
  }

  public Tematica getTematica() {
    return tematica;
  }

  public void setTematica(Tematica tematica) {
    this.tematica = tematica;
  }

  public Usuario getUsuario() {
    return usuario;
  }

  public void setUsuario(Usuario usuario) {
    this.usuario = usuario;
  }

  @Override
  public String toString() {
    return "Dibujo{" +
        "idDibujo=" + idDibujo +
        ", titulo='" + titulo + '\'' +
        ", autor=" + usuario +
        ", tematica='" + tematica + '\'' +
        '}';
  }

  @Override
  public boolean equals(Object o) {
    if (o == null || getClass() != o.getClass()) return false;
    Dibujo dibujo = (Dibujo) o;
    return idDibujo == dibujo.idDibujo &&
        Objects.equals(titulo, dibujo.titulo) &&
        Objects.equals(usuario, dibujo.usuario) &&
        Objects.equals(tematica, dibujo.tematica);
  }

  @Override
  public int hashCode() {
    return Objects.hash(idDibujo, titulo, usuario, tematica);
  }


  @Override
  public int compareTo(Object o) {
    return 0;
  }
}
