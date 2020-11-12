package com.grupo.de.pessoas.tristes.gepeto.repositories;

import com.grupo.de.pessoas.tristes.gepeto.dtos.FinalGrade;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

@Repository
public class FinalGradeRepository {

    EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("TestPersistence");
    private EntityManager getEntityManager() {
        return entityManagerFactory.createEntityManager();
    }

    @PersistenceContext
    EntityManager entityManager;

    //GET
    @Transactional
    public List<FinalGrade> showFinalGrades() {
        entityManager = getEntityManager();
        StoredProcedureQuery getFinalGradesStoredProcedureQuery = entityManager
                .createNamedStoredProcedureQuery("SP_SHOW_MEDIUM_GRADE_GROUP");

        getFinalGradesStoredProcedureQuery.execute();

        List<FinalGrade> resultList = getFinalGradesStoredProcedureQuery.getResultList();

        Iterator iterator = resultList.iterator();

        List<FinalGrade> finalGradeList = new ArrayList<>();

        while (iterator.hasNext()) {
            Object[] object = (Object[]) iterator.next();

            String nameCriterion = String.valueOf(object[0]);
            double grade = Double.parseDouble(String.valueOf(object[1]));

            FinalGrade finalGrade = new FinalGrade();

            finalGrade.setNameCriterion(nameCriterion);
            finalGrade.setGrade(grade);

            finalGradeList.add(finalGrade);
        }

        entityManager.close();

        return finalGradeList;
    }

    //POST
    @Transactional
    public List<FinalGrade> showFinalGrades(Long groupId) {
        entityManager = getEntityManager();
        StoredProcedureQuery getFinalGradesStoredProcedureQuery = entityManager
                .createNamedStoredProcedureQuery("SP_SHOW_MEDIUM_GRADE_GROUP_1");

        getFinalGradesStoredProcedureQuery
                .setParameter("group_id", groupId);

        getFinalGradesStoredProcedureQuery.execute();

        entityManager.close();

        List<FinalGrade> finalGradeList = showFinalGrades();

        return finalGradeList;
    }
}
