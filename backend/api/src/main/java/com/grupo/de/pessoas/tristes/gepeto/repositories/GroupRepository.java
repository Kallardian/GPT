package com.grupo.de.pessoas.tristes.gepeto.repositories;

import com.grupo.de.pessoas.tristes.gepeto.dtos.Group;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.*;
import java.util.Iterator;
import java.util.List;

@Repository
public class GroupRepository {

    EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("TestPersistence");
    private EntityManager getEntityManager() {
        return entityManagerFactory.createEntityManager();
    }

    @PersistenceContext
    EntityManager entityManager;

    //TODO getGroupsByClassroomId();

    @Transactional
    public Group getGroupById(Group group) {
        entityManager = getEntityManager();
        StoredProcedureQuery getGroupByIdStoredProcedureQuery = entityManager
                .createNamedStoredProcedureQuery("SP_FIND_GROUP");

        getGroupByIdStoredProcedureQuery
                .setParameter("group_id", group.getIdGroup());

        getGroupByIdStoredProcedureQuery.execute();
        List<Group> groupList = getGroupByIdStoredProcedureQuery.getResultList();

        Iterator iterator = groupList.iterator();

        while (iterator.hasNext()) {
            Object[] object = (Object[]) iterator.next();

            Long idGroup = Long.parseLong(String.valueOf(object[0]));
            String name = String.valueOf(object[1]);
            String description = String.valueOf(object[2]);
            Long idClassroom = Long.parseLong(String.valueOf(object[3]));

            group.setIdGroup(idGroup);
            group.setName(name);
            group.setDescription(description);
            group.setIdClassroom(idClassroom);
        }

        return group;
    }
}
