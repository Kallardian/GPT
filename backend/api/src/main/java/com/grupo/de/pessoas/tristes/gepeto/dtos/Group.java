package com.grupo.de.pessoas.tristes.gepeto.dtos;

import javax.persistence.*;

//Function
@NamedStoredProcedureQuery(name = "SP_GROUP_USED", procedureName = "SP_GROUP_USED",
        parameters = {
                @StoredProcedureParameter(name = "group_id", type = Long.class, mode = ParameterMode.IN)
        }
)

@NamedStoredProcedureQuery(name = "SP_AMOUNT_GROUPS_CLASSROOM", procedureName = "SP_AMOUNT_GROUPS_CLASSROOM",
        parameters = {
                @StoredProcedureParameter(name = "id_classroom", type = Long.class, mode = ParameterMode.IN)
        }
)



//GET
@NamedStoredProcedureQuery(name = "SP_FIND_GROUP", procedureName = "SP_FIND_GROUP",
        parameters = {
                @StoredProcedureParameter(name = "group_id", type = Long.class, mode = ParameterMode.IN)
        }
)

@NamedStoredProcedureQuery(name = "SP_SHOW_GROUPS", procedureName = "SP_SHOW_GROUPS",
        parameters = {
                @StoredProcedureParameter(name = "classroom_id", type = Long.class, mode = ParameterMode.IN)
        }
)

@NamedStoredProcedureQuery(name = "SP_LAST_GROUP", procedureName = "SP_LAST_GROUP")

//POST
@NamedStoredProcedureQuery( name = "SP_INSERT_GROUP", procedureName = "SP_INSERT_GROUP",
        parameters = {
                @StoredProcedureParameter(name = "group_theme", type = String.class, mode = ParameterMode.IN),
                @StoredProcedureParameter(name = "description", type = String.class, mode = ParameterMode.IN),
                @StoredProcedureParameter(name = "classroom_id", type = Long.class, mode = ParameterMode.IN),
                @StoredProcedureParameter(name = "ra", type = String.class, mode = ParameterMode.IN)
        }
)

//PUT
@NamedStoredProcedureQuery(name = "SP_UPDATE_GROUP", procedureName = "SP_UPDATE_GROUP",
        parameters = {
                @StoredProcedureParameter(name = "group_id", type = Long.class, mode = ParameterMode.IN),
                @StoredProcedureParameter(name = "classroom_id", type = Long.class, mode = ParameterMode.IN),
                @StoredProcedureParameter(name = "description", type = String.class, mode = ParameterMode.IN),
                @StoredProcedureParameter(name = "new_theme", type = String.class, mode = ParameterMode.IN)
        }
)

//DELETE
@NamedStoredProcedureQuery(name = "SP_DELETE_GROUP", procedureName = "SP_DELETE_GROUP",
        parameters = {
                @StoredProcedureParameter(name = "group_id", type = Long.class, mode = ParameterMode.IN)
        }
)

@Entity
@Table(name = "TB_GROUP")
public class Group {

    //Attributes
    @Id
    @Column(name = "ID_GROUP")
    private Long idGroup;
    @Column(name = "GROUP_THEME")
    private String groupTheme;
    @Column(name = "GROUP_DESCRIPTION")
    private String description;
    @Column(name = "ID_CLASSROOM")
    private Long idClassroom;
    @Column(name = "RA")
    private String ra;


    //Methods
    public Long getIdGroup() {
        return idGroup;
    }

    public void setIdGroup(Long idGroup) {
        this.idGroup = idGroup;
    }

    public String getGroupTheme() {
        return groupTheme;
    }

    public void setGroupTheme(String groupTheme) {
        this.groupTheme = groupTheme;
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

    public String getRa() {
        return ra;
    }

    public void setRa(String ra) {
        this.ra = ra;
    }
}
