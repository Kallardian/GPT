package com.grupo.de.pessoas.tristes.gepeto.repositories;

import com.grupo.de.pessoas.tristes.gepeto.dtos.Classroom;
import com.grupo.de.pessoas.tristes.gepeto.dtos.User;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.*;
import java.util.Iterator;
import java.util.List;

@Repository
public class ClassroomRepository {

    EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("TestPersistence");
    private EntityManager getEntityManager() {
        return entityManagerFactory.createEntityManager();
    }

    @PersistenceContext
    EntityManager entityManager;

    //Function
    @Transactional
    public int amountOfClassrooms() {
        entityManager = getEntityManager();
        StoredProcedureQuery amountOfClassroomsStoredProcedureQuery = entityManager
                .createNamedStoredProcedureQuery("SP_AMOUNT_CLASSROOMS");

        amountOfClassroomsStoredProcedureQuery.execute();

        List<Classroom> classroomList = amountOfClassroomsStoredProcedureQuery.getResultList();

        Iterator iterator = classroomList.iterator();

        int amount = 0;
        while (iterator.hasNext()) {
            amount = Integer.parseInt(String.valueOf(iterator.next()));
        }

        return amount;
    }

    //GET
    @Transactional
    public Classroom getClassroomById(Classroom classroom) {
        entityManager = getEntityManager();
        StoredProcedureQuery getClassroomByIdStoredProcedureQuery = entityManager
                .createNamedStoredProcedureQuery("SP_FIND_CLASSROOM");

        getClassroomByIdStoredProcedureQuery
                .setParameter("classroom_id", classroom.getIdClassroom());

        getClassroomByIdStoredProcedureQuery.execute();

        List<Classroom> classroomList = getClassroomByIdStoredProcedureQuery.getResultList();

        Iterator iterator = classroomList.iterator();

        while (iterator.hasNext()) {
            Object[] object = (Object[]) iterator.next();

            Long idClassroom = Long.parseLong(String.valueOf(object[0]));
            String nameClassroom = String.valueOf(object[1]);
            int year = Integer.parseInt(String.valueOf(object[2]));

            classroom.setIdClassroom(idClassroom);
            classroom.setNameClassroom(nameClassroom);
            classroom.setYear(year);
        }

        return classroom;
    }

    @Transactional
    public List<Classroom> showClassrooms() {
        entityManager = getEntityManager();
        StoredProcedureQuery showClassroomsStoredProcedureQuery = entityManager
                .createNamedStoredProcedureQuery("SP_SHOW_CLASSROOMS");

        showClassroomsStoredProcedureQuery.execute();

        List<Classroom> classroomList = showClassroomsStoredProcedureQuery.getResultList();

        Iterator iterator = classroomList.iterator();

        while (iterator.hasNext()) {
            Object[] object = (Object[]) iterator.next();

            Long idClassroom = Long.parseLong(String.valueOf(object[0]));
            String nameClassroom = String.valueOf(object[1]);
            int year = Integer.parseInt(String.valueOf(object[2]));
        }

        return classroomList;
    }

    //POST
    @Transactional
    public void postClassrooms(int amount) {
        entityManager = getEntityManager();
        StoredProcedureQuery postClassroomsStoredProcedureQuery = entityManager
                .createNamedStoredProcedureQuery("SP_INSERT_CLASSROOM");

        postClassroomsStoredProcedureQuery
                .setParameter("amount_classroom", amount);

        postClassroomsStoredProcedureQuery.execute();
    }

    //DELETE
    @Transactional
    public void deleteClassroom(Classroom classroom) {
        entityManager = getEntityManager();
        StoredProcedureQuery deleteClassroomStoredProcedureQuery = entityManager
                .createNamedStoredProcedureQuery("SP_DELETE_CLASSROOM");

        deleteClassroomStoredProcedureQuery
                .setParameter("classroom_id", classroom.getIdClassroom());

        deleteClassroomStoredProcedureQuery.execute();

    }

}
