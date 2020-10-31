package com.grupo.de.pessoas.tristes.gepeto.repositories;

import com.grupo.de.pessoas.tristes.gepeto.dtos.BigCriterion;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.*;
import java.util.Iterator;
import java.util.List;

@Repository
public class BigCriterionRepository {

    EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("TestPersistence");
    private EntityManager getEntityManager() {
        return entityManagerFactory.createEntityManager();
    }

    @PersistenceContext
    EntityManager entityManager;

    //GET
    @Transactional
    public BigCriterion getBigCriterionById(BigCriterion bigCriterion) {
        entityManager = getEntityManager();
        StoredProcedureQuery getBigCriterionByIdStoredProcedureQuery = entityManager
                .createNamedStoredProcedureQuery("SP_FIND_BIG_CRITERION");

        getBigCriterionByIdStoredProcedureQuery
                .setParameter("id_big", bigCriterion.getIdBig());

        getBigCriterionByIdStoredProcedureQuery.execute();

        List<BigCriterion> bigCriterionList = getBigCriterionByIdStoredProcedureQuery.getResultList();

        Iterator iterator = bigCriterionList.iterator();

        while (iterator.hasNext()) {
            Object[] object = (Object[]) iterator.next();

            Long idBig = Long.parseLong(String.valueOf(object[0]));
            int year = Integer.parseInt(String.valueOf(object[1]));

            bigCriterion.setIdBig(idBig);
            bigCriterion.setYear(year);
        }

        return bigCriterion;
    }

    @Transactional
    public List<BigCriterion> showBigCriteria() {
        entityManager = getEntityManager();
        StoredProcedureQuery getBigCriteriaStoredProcedureQuery = entityManager
                .createNamedStoredProcedureQuery("SP_SHOW_BIG_CRITERION");

        getBigCriteriaStoredProcedureQuery.execute();

        List<BigCriterion> bigCriteriaList = getBigCriteriaStoredProcedureQuery.getResultList();

        Iterator iterator = bigCriteriaList.iterator();

        while (iterator.hasNext()) {
            Object[] object = (Object[]) iterator.next();

            Long idBig = Long.parseLong(String.valueOf(object[0]));
            int year = Integer.parseInt(String.valueOf(object[1]));
        }

        return bigCriteriaList;
    }

    //POST
    @Transactional
    public void postBigCriterion() {
        entityManager = getEntityManager();
        StoredProcedureQuery postBigCriterionStoredProcedureQuery = entityManager
                .createNamedStoredProcedureQuery("SP_INSERT_BIG_CRITERION");

        postBigCriterionStoredProcedureQuery.execute();
    }
}
