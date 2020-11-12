package com.grupo.de.pessoas.tristes.gepeto.repositories;

import com.grupo.de.pessoas.tristes.gepeto.dtos.Classroom;
import com.grupo.de.pessoas.tristes.gepeto.dtos.FinalGrade;
import com.grupo.de.pessoas.tristes.gepeto.dtos.MediumGrade;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.*;
import java.util.ArrayList;
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

    //Function
    @Transactional
    public int getBiggestAttempt(Long groupId) {
        entityManager = getEntityManager();
        StoredProcedureQuery getBiggestAttemptStoredProcedureQuery = entityManager
                .createNamedStoredProcedureQuery("SP_BIGGEST_ATTEMPT");

        getBiggestAttemptStoredProcedureQuery
                .setParameter("id_group", groupId);

        getBiggestAttemptStoredProcedureQuery.execute();

        List<Classroom> classroomList = getBiggestAttemptStoredProcedureQuery.getResultList();

        Iterator iterator = classroomList.iterator();

        int biggestAttempt = 0;
        while (iterator.hasNext()) {
            biggestAttempt = Integer.parseInt(String.valueOf(iterator.next()));
        }

        entityManager.close();

        return biggestAttempt;
    }

    //GET
    @Transactional
    public MediumGrade getMediumGradeById(MediumGrade mediumGrade) {
        entityManager = getEntityManager();
        StoredProcedureQuery getMediumGradeByIdStoredProcedureQuery = entityManager
                .createNamedStoredProcedureQuery("SP_FIND_MEDIUM_GRADE");

        getMediumGradeByIdStoredProcedureQuery
                .setParameter("id_medium_grade", mediumGrade.getIdMediumGrade());

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

        entityManager.close();

        return mediumGrade;
    }

    @Transactional
    public List<MediumGrade> showMediumGrade() {
        entityManager = getEntityManager();
        StoredProcedureQuery getMediumGradesStoredProcedureQuery = entityManager
                .createNamedStoredProcedureQuery("SP_SHOW_MEDIUM_GRADE");

        getMediumGradesStoredProcedureQuery.execute();

        List<MediumGrade> resultList = getMediumGradesStoredProcedureQuery.getResultList();

        Iterator iterator = resultList.iterator();

        List<MediumGrade> mediumGradeList = new ArrayList<>();

        while (iterator.hasNext()) {
            Object[] object = (Object[]) iterator.next();

            Long idMediumGrade = Long.parseLong(String.valueOf(object[0]));
            Long idMedium = Long.parseLong(String.valueOf(object[1]));
            Long idGroup = Long.parseLong(String.valueOf(object[2]));
            String ra = String.valueOf(object[3]);
            Double grade = Double.parseDouble(String.valueOf(object[4]));
            int attempt = Integer.parseInt(String.valueOf(object[5]));

            MediumGrade mediumGrade = new MediumGrade();

            mediumGrade.setIdMediumGrade(idMediumGrade);
            mediumGrade.setRa(ra);
            mediumGrade.setIdMedium(idMedium);
            mediumGrade.setIdGroup(idGroup);
            mediumGrade.setGrade(grade);
            mediumGrade.setAttempt(attempt);

            mediumGradeList.add(mediumGrade);
        }

        entityManager.close();

        return mediumGradeList;
    }

    @Transactional
    public List<FinalGrade> showMediumGradeByGroupId(Long groupId) {
        entityManager = getEntityManager();
        StoredProcedureQuery showMediumGradeByGroupIdStoredProcedureQuery = entityManager
                .createNamedStoredProcedureQuery("SP_SHOW_MEDIUM_GRADE_GROUP");

        showMediumGradeByGroupIdStoredProcedureQuery
                .setParameter("group_id", groupId);

        showMediumGradeByGroupIdStoredProcedureQuery.execute();

        List<FinalGrade> resultList = showMediumGradeByGroupIdStoredProcedureQuery.getResultList();

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

    @Transactional
    public double finalMediumGradeByGroupId(Long groupId) {
        entityManager = getEntityManager();
        StoredProcedureQuery getMediumGradesByGroupIdStoredProcedureQuery = entityManager
                .createNamedStoredProcedureQuery("SP_SHOW_FINAL_GRADE_GROUP");

        getMediumGradesByGroupIdStoredProcedureQuery
                .setParameter("group_id", groupId);

        getMediumGradesByGroupIdStoredProcedureQuery.execute();

        List<MediumGrade> resultList = getMediumGradesByGroupIdStoredProcedureQuery.getResultList();

        Iterator iterator = resultList.iterator();

        List<MediumGrade> mediumGradeList = new ArrayList<>();

        while (iterator.hasNext()) {
            Object[] object = (Object[]) iterator.next();

            Long idMediumGrade = Long.parseLong(String.valueOf(object[0]));
            String ra = String.valueOf(object[1]);
            Long idMedium = Long.parseLong(String.valueOf(object[2]));
            Long idGroup = Long.parseLong(String.valueOf(object[3]));
            Double grade = Double.parseDouble(String.valueOf(object[4]));
            int attempt = Integer.parseInt(String.valueOf(object[5]));

            MediumGrade mediumGrade = new MediumGrade();

            mediumGrade.setIdMediumGrade(idMediumGrade);
            mediumGrade.setRa(ra);
            mediumGrade.setIdMedium(idMedium);
            mediumGrade.setIdGroup(idGroup);
            mediumGrade.setGrade(grade);
            mediumGrade.setAttempt(attempt);

            mediumGradeList.add(mediumGrade);
        }

        double finalGrade = mediumGradeList.stream().mapToInt(mediumGrade -> (int) mediumGrade.getGrade()).sum();

        MediumCriterionRepository mediumCriterionRepository = new MediumCriterionRepository();

        double amount = mediumCriterionRepository.showMediumCriteria().size();

        double grades = mediumGradeList.size() / amount;

        finalGrade /= grades;

        entityManager.close();

        return finalGrade;
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

        entityManager.close();
    }
}
