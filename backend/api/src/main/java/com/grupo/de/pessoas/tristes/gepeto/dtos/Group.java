package com.grupo.de.pessoas.tristes.gepeto.dtos;

import javax.persistence.*;

@NamedStoredProcedureQuery(
        name = "SP_FIND_GROUP",
        procedureName = "SP_FIND_GROUP",
        parameters = {
                @StoredProcedureParameter(name = "group_id", type = Long.class, mode = ParameterMode.IN)
        }
)

@Entity
@Table(name = "TB_GROUP")
public class Group {

    @Id
    @Column(name = "ID_GROUP")
    private Long idGroup;
    @Column(name = "GROUP_THEME")
    private String name;
    @Column(name = "GROUP_DESCRIPTION")
    private String description;
    @Column(name = "ID_CLASSROOM")
    private Long idClassroom;

    public Long getIdGroup() {
        return idGroup;
    }

    public void setIdGroup(Long idGroup) {
        this.idGroup = idGroup;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Long getIdClassroom() {
        return idClassroom;
    }

    public void setIdClassroom(Long idClassroom) {
        this.idClassroom = idClassroom;
    }
}
