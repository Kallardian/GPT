package com.grupo.de.pessoas.tristes.gepeto.repositories;

import com.grupo.de.pessoas.tristes.gepeto.dtos.MediumCriterion;
import com.grupo.de.pessoas.tristes.gepeto.dtos.User;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.*;
import java.util.Iterator;
import java.util.List;

@Repository
public class MediumCriterionRepository {

    EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("TestPersistence");
    private EntityManager getEntityManager() {
        return entityManagerFactory.createEntityManager();
    }

    @PersistenceContext
    EntityManager entityManager;

    //GET
    @Transactional
    public MediumCriterion getMediumCriterionById(MediumCriterion mediumCriterion) {
        entityManager = getEntityManager();
        StoredProcedureQuery getMediumCriterionByIdStoredProcedureQuery = entityManager
                .createNamedStoredProcedureQuery("SP_FIND_MEDIUM_CRITERION");

        getMediumCriterionByIdStoredProcedureQuery
                .setParameter("id_medium", mediumCriterion.getIdMedium());

        getMediumCriterionByIdStoredProcedureQuery.execute();

        List<MediumCriterion> mediumCriterionList = getMediumCriterionByIdStoredProcedureQuery.getResultList();

        Iterator iterator = mediumCriterionList.iterator();

        while (iterator.hasNext()) {
            Object[] object = (Object[]) iterator.next();

            Long idMedium = Long.parseLong(String.valueOf(object[0]));
            Long idBig = Long.parseLong(String.valueOf(object[1]));
            String ra = String.valueOf(object[2]);
            String nameMedium = String.valueOf(object[3]);
            String description = String.valueOf(object[4]);
            Double totalValue = Double.parseDouble(String.valueOf(object[5]));

            mediumCriterion.setIdMedium(idMedium);
            mediumCriterion.setIdBig(idBig);
            mediumCriterion.setRa(ra);
            mediumCriterion.setNameMedium(nameMedium);
            mediumCriterion.setDescription(description);
            mediumCriterion.setTotalValue(totalValue);
        }

        return mediumCriterion;
    }

    @Transactional
    public List<MediumCriterion> showMediumCriteria() {
        entityManager = getEntityManager();
        StoredProcedureQuery getMediumCriteriaStoredProcedureQuery = entityManager
                .createNamedStoredProcedureQuery("SP_SHOW_MEDIUM_CRITERION");

        getMediumCriteriaStoredProcedureQuery.execute();

        List<MediumCriterion> mediumCriterionList = getMediumCriteriaStoredProcedureQuery.getResultList();

        Iterator iterator = mediumCriterionList.iterator();

        while (iterator.hasNext()) {
            Object[] object = (Object[]) iterator.next();

            Long idMedium = Long.parseLong(String.valueOf(object[0]));
            Long idBig = Long.parseLong(String.valueOf(object[1]));
            String ra = String.valueOf(object[2]);
            String nameMedium = String.valueOf(object[3]);
            String description = String.valueOf(object[4]);
            Double totalValue = Double.parseDouble(String.valueOf(object[5]));
        }

        return mediumCriterionList;
    }

    //POST
    @Transactional
    public void postMediumCriterion(MediumCriterion mediumCriterion) {
        entityManager = getEntityManager();
        StoredProcedureQuery postMediumCriterionStoredProcedureQuery = entityManager
                .createNamedStoredProcedureQuery("SP_INSERT_MEDIUM_CRITERION");

        postMediumCriterionStoredProcedureQuery
                .setParameter("id_big", mediumCriterion.getIdBig())
                .setParameter("name_medium", mediumCriterion.getNameMedium())
                .setParameter("ra", mediumCriterion.getRa())
                .setParameter("description", mediumCriterion.getDescription())
                .setParameter("value", mediumCriterion.getTotalValue());

        postMediumCriterionStoredProcedureQuery.execute();
    }

    //PUT
    @Transactional
    public void updateMediumCriterion(MediumCriterion mediumCriterion) {
        entityManager = getEntityManager();
        StoredProcedureQuery updateMediumCriterionStoredProcedureQuery = entityManager
                .createNamedStoredProcedureQuery("SP_UPDATE_MEDIUM_CRITERION");

        updateMediumCriterionStoredProcedureQuery
                .setParameter("id_medium", mediumCriterion.getIdMedium())
                .setParameter("name_medium", mediumCriterion.getNameMedium())
                .setParameter("description", mediumCriterion.getDescription())
                .setParameter("value", mediumCriterion.getTotalValue());

        updateMediumCriterionStoredProcedureQuery.execute();
    }

    //DELETE
    @Transactional
    public void deleteMediumCriterion(MediumCriterion mediumCriterion) {
        entityManager = getEntityManager();
        StoredProcedureQuery deleteMediumCriterionStoredProcedureQuery = entityManager
                .createNamedStoredProcedureQuery("SP_DELETE_MEDIUM_CRITERION");

        deleteMediumCriterionStoredProcedureQuery
                .setParameter("id_medium", mediumCriterion.getIdMedium());

        deleteMediumCriterionStoredProcedureQuery.execute();
    }
}
