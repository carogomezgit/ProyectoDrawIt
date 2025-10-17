package org.drawit.entities;

public class Usuario implements Comparable {

  private int idUsuario;
  private String nombre;
  private String apellido;
  private String correo;

  // constructor
  public Usuario (){
  }

  public Usuario (String nombre, String apellido, String correo){
    this.nombre = nombre;
    this.apellido = apellido;
    this.correo = correo;
  }

  public int getIdUsuario() {
    return idUsuario;
  }

  public void setUsuarioId(int idUsuario) {
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

  @Override
  public String toString() {
    return "Usuario{" +
        "usuarioId=" + idUsuario +
        ", nombre='" + nombre + '\'' +
        ", apellido='" + apellido + '\'' +
        ", correo='" + correo + '\'' +
        '}';
  }

  @Override
  public int compareTo(Object o) {
    Usuario otro= (Usuario) o;
    int comparacionApellido = this.apellido.compareTo(otro.apellido);

    if (comparacionApellido != 0) {
      return comparacionApellido;
    }

    return this.nombre.compareTo(otro.nombre);
  }
}

