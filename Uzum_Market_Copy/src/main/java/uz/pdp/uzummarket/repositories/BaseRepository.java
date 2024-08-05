package uz.pdp.uzummarket.repositories;

import java.util.List;

public interface BaseRepository<M>{

    void save(M m);
    boolean delete(M m);
    M get(Integer id);
    List<M> getAll();
    void update(M m);
}