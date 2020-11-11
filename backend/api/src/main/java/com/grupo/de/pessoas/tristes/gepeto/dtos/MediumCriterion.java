package com.grupo.de.pessoas.tristes.gepeto.dtos;

import javax.persistence.*;

//Function
@NamedStoredProcedureQuery(name = "SP_CRITERION_USED", procedureName = "SP_CRITERION_USED",
        parameters = {
                @StoredProcedureParameter(name = "criterion_id", type = Long.class, mode = ParameterMode.IN)
        }
)


//GET
@NamedStoredProcedureQuery(name = "SP_FIND_MEDIUM_CRITERION", procedureName = "SP_FIND_MEDIUM_CRITERION",
        parameters = {
                @StoredProcedureParameter(name = "id_medium", type = Long.class, mode = ParameterMode.IN)
        }
)

@NamedStoredProcedureQuery(name = "SP_SHOW_MEDIUM_CRITERION", procedureName = "SP_SHOW_MEDIUM_CRITERION")

//POST
@NamedStoredProcedureQuery( name = "SP_INSERT_MEDIUM_CRITERION", procedureName = "SP_INSERT_MEDIUM_CRITERION",
        parameters = {
                @StoredProcedureParameter(name = "id_big", type = Long.class, mode = ParameterMode.IN),
                @StoredProcedureParameter(name = "name_medium", type = String.class, mode = ParameterMode.IN),
                @StoredProcedureParameter(name = "ra", type = String.class, mode = ParameterMode.IN),
                @StoredProcedureParameter(name = "description", type = String.class, mode = ParameterMode.IN),
                @StoredProcedureParameter(name = "value", type = Double.class, mode = ParameterMode.IN)
        }
)

//PUT
@NamedStoredProcedureQuery(name = "SP_UPDATE_MEDIUM_CRITERION", procedureName = "SP_UPDATE_MEDIUM_CRITERION",
        parameters = {
                @StoredProcedureParameter(name = "id_medium", type = Long.class, mode = ParameterMode.IN),
                @StoredProcedureParameter(name = "name_medium", type = String.class, mode = ParameterMode.IN),
                @StoredProcedureParameter(name = "description", type = String.class, mode = ParameterMode.IN),
                @StoredProcedureParameter(name = "value", type = Double.class, mode = ParameterMode.IN)
        }
)

//DELETE
@NamedStoredProcedureQuery(name = "SP_DELETE_MEDIUM_CRITERION", procedureName = "SP_DELETE_MEDIUM_CRITERION",
        parameters = {
                @StoredProcedureParameter(name = "id_medium", type = Long.class, mode = ParameterMode.IN),
        }
)

@Entity
@Table(name = "TB_MEDIUM_CRITERION")
public class MediumCriterion {

    //Attributes
    @Id
    @Column(name = "ID_MEDIUM")
    private Long idMedium;
    @Column(name = "ID_BIG")
    private Long idBig;
    @Column(name = "RA")
    private String ra;
    @Column(name = "NAME_MEDIUM")
    private String nameMedium;
    @Column(name = "DESCRIPTION")
    private String description;
    @Column(name = "TOTAL_VALUE")
    private double totalValue;


    //Methods
    public Long getIdMedium() {
        return idMedium;
    }

    public void setIdMedium(Long idMedium) {
        this.idMedium = idMedium;
    }

    public Long getIdBig() {
        return idBig;
    }

    public void setIdBig(Long idBig) {
        this.idBig = idBig;
    }

    public String getRa() {
        return ra;
    }

    public void setRa(String ra) {
        this.ra = ra;
    }

    public String getNameMedium() {
        return nameMedium;
    }

    public void setNameMedium(String nameMedium) {
        this.nameMedium = nameMedium;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getTotalValue() {
        return totalValue;
    }

    public void setTotalValue(double totalValue) {
        this.totalValue = totalValue;
    }
}
