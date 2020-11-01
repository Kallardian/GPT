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

    //GET
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
            String groupTheme = String.valueOf(object[1]);
            String description = String.valueOf(object[2]);
            Long idClassroom = Long.parseLong(String.valueOf(object[3]));
            String ra = String.valueOf(object[4]);

            group.setIdGroup(idGroup);
            group.setGroupTheme(groupTheme);
            group.setDescription(description);
            group.setIdClassroom(idClassroom);
            group.setRa(ra);
        }

        return group;
    }

    @Transactional
    public List<Group> showGroups() {
        entityManager = getEntityManager();
        StoredProcedureQuery showGroupsStoredProcedureQuery = entityManager
                .createNamedStoredProcedureQuery("SP_SHOW_GROUPS");

        showGroupsStoredProcedureQuery.execute();

        List<Group> groupList = showGroupsStoredProcedureQuery.getResultList();

        Iterator iterator = groupList.iterator();

        while (iterator.hasNext()) {
            Object[] object = (Object[]) iterator.next();

            Long idGroup = Long.parseLong(String.valueOf(object[0]));
            String groupTheme = String.valueOf(object[1]);
            String description = String.valueOf(object[2]);
            Long idClassroom = Long.parseLong(String.valueOf(object[3]));
            String ra = String.valueOf(object[4]);
        }

        return groupList;
    }

    //POST
    @Transactional
    public void postGroup(Group group) {
        entityManager = getEntityManager();
        StoredProcedureQuery postGroupStoredProcedureQuery = entityManager
                .createNamedStoredProcedureQuery("SP_INSERT_GROUP");

        postGroupStoredProcedureQuery
                .setParameter("group_theme", group.getGroupTheme())
                .setParameter("description", group.getDescription())
                .setParameter("classroom_id", group.getIdClassroom())
                .setParameter("ra", group.getRa());

        postGroupStoredProcedureQuery.execute();
    }

    //PUT
    @Transactional
    public void updateGroup(Group group) {
        entityManager = getEntityManager();
        StoredProcedureQuery updateGroupStoredProcedureQuery = entityManager
                .createNamedStoredProcedureQuery("SP_UPDATE_GROUP");

        updateGroupStoredProcedureQuery
                .setParameter("group_id", group.getIdGroup())
                .setParameter("classroom_id", group.getIdClassroom())
                .setParameter("description", group.getDescription())
                .setParameter("new_theme", group.getGroupTheme());

        updateGroupStoredProcedureQuery.execute();
    }

    //DELETE
    @Transactional
    public void deleteGroup(Group group) {
        entityManager = getEntityManager();
        StoredProcedureQuery deleteGroupStoredProcedureQuery = entityManager
                .createNamedStoredProcedureQuery("SP_DELETE_GROUP");

        deleteGroupStoredProcedureQuery
                .setParameter("group_theme", group.getGroupTheme())
                .setParameter("classroom_id", group.getIdClassroom());

        deleteGroupStoredProcedureQuery.execute();
    }
}
