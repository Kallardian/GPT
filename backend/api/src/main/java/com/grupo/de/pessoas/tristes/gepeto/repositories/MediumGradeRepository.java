package com.grupo.de.pessoas.tristes.gepeto.repositories;

import com.grupo.de.pessoas.tristes.gepeto.dtos.MediumGrade;
import com.grupo.de.pessoas.tristes.gepeto.dtos.User;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.*;
import java.util.Iterator;
import java.util.List;

@Repository
public class MediumGradeRepository {

    EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("TestPersistence");
    private EntityManager getEntityManager() {
        return entityManagerFactory.createEntityManager();
    }

    @PersistenceContext
    EntityManager entityManager;

    //GET
    @Transactional
    public MediumGrade getMediumGradeById(MediumGrade mediumGrade) {
        entityManager = getEntityManager();
        StoredProcedureQuery getMediumGradeByIdStoredProcedureQuery = entityManager
                .createNamedStoredProcedureQuery("SP_FIND_MEDIUM_GRADE");

        getMediumGradeByIdStoredProcedureQuery
                .setParameter("id_medium_grade", mediumGrade.getIdGroup());

        getMediumGradeByIdStoredProcedureQuery.execute();

        List<MediumGrade> mediumGradeList = getMediumGradeByIdStoredProcedureQuery.getResultList();

        Iterator iterator = mediumGradeList.iterator();

        while (iterator.hasNext()) {
            Object[] object = (Object[]) iterator.next();

            Long idMediumGrade = Long.parseLong(String.valueOf(object[0]));
            String ra = String.valueOf(object[1]);
            Long idMedium = Long.parseLong(String.valueOf(object[2]));
            Long idGroup = Long.parseLong(String.valueOf(object[3]));
            Double grade = Double.parseDouble(String.valueOf(object[4]));
            int attempt = Integer.parseInt(String.valueOf(object[5]));

            mediumGrade.setIdMediumGrade(idMediumGrade);
            mediumGrade.setRa(ra);
            mediumGrade.setIdMedium(idMedium);
            mediumGrade.setIdGroup(idGroup);
            mediumGrade.setGrade(grade);
            mediumGrade.setAttempt(attempt);
        }

        return mediumGrade;
    }

    @Transactional
    public List<MediumGrade> showMediumGrade() {
        entityManager = getEntityManager();
        StoredProcedureQuery getMediumGradesStoredProcedureQuery = entityManager
                .createNamedStoredProcedureQuery("SP_SHOW_MEDIUM_GRADE");

        getMediumGradesStoredProcedureQuery.execute();

        List<MediumGrade> mediumGradeList = getMediumGradesStoredProcedureQuery.getResultList();

        Iterator iterator = mediumGradeList.iterator();

        while (iterator.hasNext()) {
            Object[] object = (Object[]) iterator.next();

            Long idMediumGrade = Long.parseLong(String.valueOf(object[0]));
            String ra = String.valueOf(object[1]);
            Long idMedium = Long.parseLong(String.valueOf(object[2]));
            Long idGroup = Long.parseLong(String.valueOf(object[3]));
            Double grade = Double.parseDouble(String.valueOf(object[4]));
            int attempt = Integer.parseInt(String.valueOf(object[5]));
        }

        return mediumGradeList;
    }

    //POST
    @Transactional
    public void postMediumGrade(MediumGrade mediumGrade) {
        entityManager = getEntityManager();
        StoredProcedureQuery postMediumGradeStoredProcedureQuery = entityManager
                .createNamedStoredProcedureQuery("SP_INSERT_MEDIUM_GRADE");

        postMediumGradeStoredProcedureQuery
                .setParameter("id_medium", mediumGrade.getIdMedium())
                .setParameter("ra", mediumGrade.getRa())
                .setParameter("id_group", mediumGrade.getIdGroup())
                .setParameter("grade", mediumGrade.getGrade())
                .setParameter("attempt", mediumGrade.getAttempt());

        postMediumGradeStoredProcedureQuery.execute();
    }
}
