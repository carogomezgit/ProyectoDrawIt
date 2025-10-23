package org.drawit.entities;

import java.util.Objects;

public class Usuario implements Comparable {

  private int idUsuario;
  private String nombre;
  private String apellido;
  private String correo;
  private String contrasenia;
  private TipoUsuario tipo;

  // constructor
  public Usuario (){
  }

  public Usuario (int idUsuario, String nombre, String apellido, String correo, String contrasenia, TipoUsuario tipo){
    this.idUsuario = idUsuario;
    this.nombre = nombre;
    this.apellido = apellido;
    this.correo = correo;
    this.contrasenia = contrasenia;
    this.tipo = tipo;
  }

  public Usuario (String correo, String contrasenia, TipoUsuario tipo) {
    this.correo = correo;
    this.contrasenia = contrasenia;
    this.tipo = tipo;
  }

  public int getIdUsuario() {
    return idUsuario;
  }

  public void setIdUsuario(int idUsuario) {
    this.idUsuario = idUsuario;
  }

  public String getNombre() {
    return nombre;
  }

  public void setNombre(String nombre) {
    this.nombre = nombre;
  }

  public String getApellido() {
    return apellido;
  }

  public void setApellido(String apellido) {
    this.apellido = apellido;
  }

  public String getCorreo() {
    return correo;
  }

  public void setCorreo(String correo) {
    this.correo = correo;
  }

  public String getContrasenia() {
    return contrasenia;
  }

  public void setContrasenia(String contrasenia) {
    this.contrasenia = contrasenia;
  }

  public TipoUsuario getTipo() {
    return tipo;
  }

  public void setTipo(TipoUsuario tipo) {
    this.tipo = tipo;
  }

  @Override
  public String toString() {
    return "Usuario{" +
        "idUsuario=" + idUsuario +
        ", nombre='" + nombre + '\'' +
        ", apellido='" + apellido + '\'' +
        ", correo='" + correo + '\'' +
        ", contrasenia='" + contrasenia + '\'' +
        ", tipo=" + tipo +
        '}';
  }

  @Override
  public boolean equals(Object obj) {
    if (this == obj)
      return true;
    if (obj == null)
      return false;
    if (getClass() != obj.getClass())
      return false;
    Usuario other = (Usuario) obj;
    return Objects.equals(correo, other.correo);
  }

  @Override
  public int hashCode() {
    return Objects.hash(correo);
  }

  @Override
  public int compareTo(Object o) {
    Usuario otro = (Usuario) o;
    int comparacionCorreo = this.correo.compareTo(otro.correo);

    if (comparacionCorreo != 0) {
      return comparacionCorreo;
    }

    return this.contrasenia.compareTo(otro.contrasenia);
  }
}

