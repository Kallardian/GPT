package com.grupo.de.pessoas.tristes.gepeto.repositories;

import com.grupo.de.pessoas.tristes.gepeto.dtos.User;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.*;
import java.util.ArrayList;
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

        List<User> userList = loginStoredProcedureQuery.getResultList();

        Iterator iterator = userList.iterator();

        while (iterator.hasNext()) {
            int access = Integer.parseInt(String.valueOf(iterator.next()));

            user.setAccess(access);
        }

        entityManager.close();

        return user.getAccess();
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

        entityManager.close();

        return user;
    }

    @Transactional
    public List<User> showUsers() {
        entityManager = getEntityManager();
        StoredProcedureQuery getUsersStoredProcedureQuery = entityManager
                .createNamedStoredProcedureQuery("SP_SHOW_USERS");

        getUsersStoredProcedureQuery.execute();

        List<User> resultList = getUsersStoredProcedureQuery.getResultList();

        Iterator iterator = resultList.iterator();

        List<User> userList = new ArrayList<>();

        while (iterator.hasNext()) {
            Object[] object = (Object[]) iterator.next();

            String ra = String.valueOf(object[0]);
            String fullName = String.valueOf(object[1]);
            String password = String.valueOf(object[2]);
            int access = Integer.parseInt(String.valueOf(object[3]));

            User user = new User();

            user.setRa(ra);
            user.setFullName(fullName);
            user.setPassword(password);
            user.setAccess(access);

            userList.add(user);
        }

        entityManager.close();

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

        entityManager.close();
    }

    //PUT User
    @Transactional
    public void updateUser(User user) {
        entityManager = getEntityManager();
        StoredProcedureQuery updateUserStoredProcedureQuery = entityManager
                .createNamedStoredProcedureQuery("SP_UPDATE_USER");

        updateUserStoredProcedureQuery
                .setParameter("ra", user.getRa())
                .setParameter("name", user.getFullName())
                .setParameter("pwd", user.getPassword())
                .setParameter("access", user.getAccess());

        updateUserStoredProcedureQuery.execute();

        entityManager.close();
    }
}
