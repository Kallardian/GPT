package com.grupo.de.pessoas.tristes.gepeto.dtos;

import lombok.Data;

import javax.persistence.*;

@NamedStoredProcedureQuery(
        name = "SP_INSERT_USER",
        procedureName = "SP_INSERT_USER",
        parameters = {
                @StoredProcedureParameter(name = "user_login", type = String.class, mode = ParameterMode.IN),
                @StoredProcedureParameter(name = "user_name", type = String.class, mode = ParameterMode.IN),
                @StoredProcedureParameter(name = "user_pwd", type = String.class, mode = ParameterMode.IN),
                @StoredProcedureParameter(name = "access", type = Integer.class, mode = ParameterMode.IN)
        }
)

@NamedStoredProcedureQuery(
        name = "SP_DELETE_USER",
        procedureName = "SP_DELETE_USER",
        parameters = {
                @StoredProcedureParameter(name = "ra", type = String.class, mode = ParameterMode.IN)
        }
)

@NamedStoredProcedureQuery(
        name = "SP_FIND_USER",
        procedureName = "SP_FIND_USER",
        parameters = {
                @StoredProcedureParameter(name = "ra", type = String.class, mode = ParameterMode.IN)
        }
)

@Entity
@Table(name = "TB_USER")
@Data
public class User {

    @Id
    @Column(name = "RA")
    private String ra;
    @Column(name = "FULL_NAME")
    private String fullName;
    @Column(name = "PASSWORD")
    private String password;
    @Column(name = "ACCESS")
    private int access;
}
