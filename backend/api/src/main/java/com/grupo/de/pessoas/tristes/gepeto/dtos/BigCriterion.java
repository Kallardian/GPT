package com.grupo.de.pessoas.tristes.gepeto.dtos;

import javax.persistence.*;

//GET
@NamedStoredProcedureQuery(name = "SP_FIND_BIG_CRITERION", procedureName = "SP_FIND_BIG_CRITERION",
        parameters = {
                @StoredProcedureParameter(name = "id_big", type = Long.class, mode = ParameterMode.IN)
        }
)

@NamedStoredProcedureQuery(name = "SP_SHOW_BIG_CRITERION", procedureName = "SP_SHOW_BIG_CRITERION")

//POST
@NamedStoredProcedureQuery( name = "SP_INSERT_BIG_CRITERION", procedureName = "SP_INSERT_BIG_CRITERION")

@Entity
@Table(name = "TB_BIG_CRITERION")
public class BigCriterion {

    //Attributes
    @Id
    @Column(name = "ID_BIG")
    private Long idBig;
    @Column(name = "YEAR")
    private int year;


    //Methods
    public Long getIdBig() {
        return idBig;
    }

    public void setIdBig(Long idBig) {
        this.idBig = idBig;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }
}
