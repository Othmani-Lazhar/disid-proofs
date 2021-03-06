package org.springframework.roo.petclinic.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.roo.addon.layers.repository.jpa.annotations.RooJpaRepositoryCustomImpl;
import org.springframework.roo.petclinic.domain.Pet;
import org.springframework.roo.petclinic.domain.QPet;

import com.querydsl.core.types.Path;
import com.querydsl.jpa.JPQLQuery;

import io.springlets.data.domain.GlobalSearch;
import io.springlets.data.jpa.repository.support.QueryDslRepositorySupportExt;
import io.springlets.data.jpa.repository.support.QueryDslRepositorySupportExt.AttributeMappingBuilder;
import io.springlets.data.web.datatables.DatatablesPageable;

/**
 * = PetRepositoryImpl
 *
 * TODO Auto-generated class documentation
 *
 */ 
@RooJpaRepositoryCustomImpl(repository = PetRepositoryCustom.class)
public class PetRepositoryImpl extends QueryDslRepositorySupportExt<Pet> {
	
    /**
     * TODO Auto-generated constructor documentation
     */
    PetRepositoryImpl() {
        super(Pet.class);
    }
    
    @Override
    public Page<Pet> findAllByIdsIn(List<Long> ids, GlobalSearch globalSearch, DatatablesPageable pageable) {
        QPet pet = QPet.pet;
        JPQLQuery<Pet> query = from(pet).where(pet.id.in(ids));
        
        Path<?>[] paths = new Path<?>[] {pet.sendReminders,pet.name,pet.weight,pet.type,pet.owner,pet.createdDate,pet.createdBy,pet.modifiedDate,pet.modifiedBy};        
        applyGlobalSearch(globalSearch, query, paths);
        
        AttributeMappingBuilder mapping = buildMapper()
			.map(SEND_REMINDERS, pet.sendReminders)
			.map(NAME, pet.name)
			.map(WEIGHT, pet.weight)
			.map(TYPE, pet.type)
			.map(OWNER, pet.owner)
			.map(CREATED_DATE, pet.createdDate)
			.map(CREATED_BY, pet.createdBy)
			.map(MODIFIED_DATE, pet.modifiedDate)
			.map(MODIFIED_BY, pet.modifiedBy);
        
        applyPagination(pageable, query, mapping);
        applyOrderById(query);
        return loadPage(query, null, pet);
    }
}