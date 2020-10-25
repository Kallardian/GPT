package com.grupo.de.pessoas.tristes.gepeto.repositories;

import com.grupo.de.pessoas.tristes.gepeto.dtos.Group;
import com.grupo.de.pessoas.tristes.gepeto.dtos.User;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.*;
import java.util.Iterator;
import java.util.List;

@Repository
public class UserRepository {

    EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("TestPersistence");
    private EntityManager getEntityManager() {
        return entityManagerFactory.createEntityManager();
    }

    @PersistenceContext
    EntityManager entityManager;

    @Transactional
    public List<User> getUsers() {
        entityManager = getEntityManager();
        StoredProcedureQuery getUsersStoredProcedureQuery = entityManager
                .createNamedStoredProcedureQuery("");

        getUsersStoredProcedureQuery.execute();

        List<User> users = getUsersStoredProcedureQuery.getResultList();

        return users;
    }

    @Transactional
    public User getUserById(User user) {
        entityManager = getEntityManager();
        StoredProcedureQuery getUserByIdStoredProcedureQuery = entityManager
                .createNamedStoredProcedureQuery("SP_FIND_USER");

        getUserByIdStoredProcedureQuery
                .setParameter("ra", user.getRa());

        getUserByIdStoredProcedureQuery.execute();

        List<Group> userList = getUserByIdStoredProcedureQuery.getResultList();

        Iterator iterator = userList.iterator();

        while (iterator.hasNext()) {
            Object[] object = (Object[]) iterator.next();

            String ra = String.valueOf(object[0]);
            String fullName = String.valueOf(object[1]);
            String password = String.valueOf(object[2]);
            int access = Integer.parseInt(String.valueOf(object[3]));

            user.setRa(ra);
            user.setFullName(fullName);
            user.setPassword(password);
            user.setAccess(access);
        }

        return user;
    }

    @Transactional
    public void postUser(User user) {
        entityManager = getEntityManager();
        StoredProcedureQuery postUserStoredProcedureQuery = entityManager
                .createNamedStoredProcedureQuery("SP_INSERT_USER");

        postUserStoredProcedureQuery
                .setParameter("user_login", user.getRa())
                .setParameter("user_name", user.getFullName())
                .setParameter("user_pwd", user.getPassword())
                .setParameter("access", user.getAccess());

        postUserStoredProcedureQuery.execute();
    }

    @Transactional
    public void deleteUser(User user) {
        entityManager = getEntityManager();
        StoredProcedureQuery deleteUserStoredProcedureQuery = entityManager
                .createNamedStoredProcedureQuery("SP_DELETE_USER");

        deleteUserStoredProcedureQuery
                .setParameter("ra", user.getRa());

        deleteUserStoredProcedureQuery.execute();
    }
}
