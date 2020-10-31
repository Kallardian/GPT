package com.grupo.de.pessoas.tristes.gepeto.repositories;

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

    //Function User
    @Transactional
    public int login(User user) {
        entityManager = getEntityManager();
        StoredProcedureQuery loginStoredProcedureQuery = entityManager
                .createNamedStoredProcedureQuery("SP_LOGIN_USER");

        loginStoredProcedureQuery.setParameter("RA", user.getRa());
        loginStoredProcedureQuery.setParameter("pwd", user.getPassword());

        loginStoredProcedureQuery.execute();

        int access = (int) loginStoredProcedureQuery.getSingleResult();

        return access;
    }

    //GET User
    @Transactional
    public User getUserById(User user) {
        entityManager = getEntityManager();
        StoredProcedureQuery getUserByIdStoredProcedureQuery = entityManager
                .createNamedStoredProcedureQuery("SP_FIND_USER");

        getUserByIdStoredProcedureQuery
                .setParameter("ra", user.getRa());

        getUserByIdStoredProcedureQuery.execute();

        List<User> userList = getUserByIdStoredProcedureQuery.getResultList();

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
    public List<User> showUsers() {
        entityManager = getEntityManager();
        StoredProcedureQuery getUsersStoredProcedureQuery = entityManager
                .createNamedStoredProcedureQuery("SP_SHOW_USERS");

        getUsersStoredProcedureQuery.execute();

        List<User> userList = getUsersStoredProcedureQuery.getResultList();

        Iterator iterator = userList.iterator();

        while (iterator.hasNext()) {
            Object[] object = (Object[]) iterator.next();

            String ra = String.valueOf(object[0]);
            String fullName = String.valueOf(object[1]);
            String password = String.valueOf(object[2]);
            int access = Integer.parseInt(String.valueOf(object[3]));
        }

        return userList;
    }

    //POST User
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

    //PUT User
    @Transactional
    public void updateUser(User user) {
        entityManager = getEntityManager();
        StoredProcedureQuery updateUserStoredProcedureQuery = entityManager
                .createNamedStoredProcedureQuery("SP_UPDATE_USER");

        updateUserStoredProcedureQuery
                .setParameter("user_login", user.getRa())
                .setParameter("user_name", user.getFullName())
                .setParameter("user_pwd", user.getPassword())
                .setParameter("access", user.getAccess());

        updateUserStoredProcedureQuery.execute();
    }

    //DELETE User
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
