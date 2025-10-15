package org.drawit.interfaces;

import java.util.List;

public interface DAO<O,K> {
  // O objeto K key clave primaria

  /*
  insert
  update
  delete
  getAll
  getById
  exists
  */

  public List<O> getAll();
  public void insert(O objeto);
  public void update(O objeto);
  public void delete(K id);
  public O getById(K id);
  public boolean existsById(K id);
}
