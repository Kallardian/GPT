package com.grupo.de.pessoas.tristes.gepeto.repositories;

import com.grupo.de.pessoas.tristes.gepeto.dtos.Classroom;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.*;

@Repository
public class ClassroomRepository {

    EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("TestPersistence");
    private EntityManager getEntityManager() {
        return entityManagerFactory.createEntityManager();
    }

    @PersistenceContext
    EntityManager entityManager;

    @Transactional
    public Classroom getClassroomById(Classroom classroom) {
        entityManager = getEntityManager();
        StoredProcedureQuery getClassroomByIdStoredProcedureQuery = entityManager
                .createNamedStoredProcedureQuery("SP_FIND_CLASSROOM");

        getClassroomByIdStoredProcedureQuery
                .setParameter("classroom_id", classroom.getIdClassroom());

        getClassroomByIdStoredProcedureQuery.execute();
        classroom = (Classroom) getClassroomByIdStoredProcedureQuery.getSingleResult();

        return classroom;
    }
}
