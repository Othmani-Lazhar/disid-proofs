// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.springframework.roo.petclinic.service.impl;

import io.springlets.data.domain.GlobalSearch;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.roo.petclinic.domain.Owner;
import org.springframework.roo.petclinic.domain.Pet;
import org.springframework.roo.petclinic.domain.PetNameAndWeightFormBean;
import org.springframework.roo.petclinic.domain.Visit;
import org.springframework.roo.petclinic.reference.PetType;
import org.springframework.roo.petclinic.repository.PetRepository;
import org.springframework.roo.petclinic.service.api.PetService;
import org.springframework.roo.petclinic.service.api.VisitService;
import org.springframework.roo.petclinic.service.impl.PetServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

privileged aspect PetServiceImpl_Roo_Service_Impl {
    
    declare parents: PetServiceImpl implements PetService;
    
    declare @type: PetServiceImpl: @Service;
    
    declare @type: PetServiceImpl: @Transactional(readOnly = true);
    
    /**
     * TODO Auto-generated attribute documentation
     */
    private PetRepository PetServiceImpl.petRepository;
    
    /**
     * TODO Auto-generated attribute documentation
     */
    private VisitService PetServiceImpl.visitService;
    
    /**
     * TODO Auto-generated constructor documentation
     * 
     * @param petRepository
     * @param visitService
     */
    @Autowired
    public PetServiceImpl.new(PetRepository petRepository, @Lazy VisitService visitService) {
        this.petRepository = petRepository;
        this.visitService = visitService;
    }

    /**
     * TODO Auto-generated method documentation
     * 
     * @param pet
     * @param visitsToAdd
     * @return Pet
     */
    @Transactional
    public Pet PetServiceImpl.addToVisits(Pet pet, Iterable<Long> visitsToAdd) {
        List<Visit> visits = visitService.findAll(visitsToAdd);
        pet.addToVisits(visits);
        return petRepository.save(pet);
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param pet
     * @param visitsToRemove
     * @return Pet
     */
    @Transactional
    public Pet PetServiceImpl.removeFromVisits(Pet pet, Iterable<Long> visitsToRemove) {
        List<Visit> visits = visitService.findAll(visitsToRemove);
        pet.removeFromVisits(visits);
        return petRepository.save(pet);
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param pet
     * @param visits
     * @return Pet
     */
    @Transactional
    public Pet PetServiceImpl.setVisits(Pet pet, Iterable<Long> visits) {
        List<Visit> items = visitService.findAll(visits);
        Set<Visit> currents = pet.getVisits();
        Set<Visit> toRemove = new HashSet<Visit>();
        for (Iterator<Visit> iterator = currents.iterator(); iterator.hasNext();) {
            Visit nextVisit = iterator.next();
            if (items.contains(nextVisit)) {
                items.remove(nextVisit);
            } else {
                toRemove.add(nextVisit);
            }
        }
        pet.removeFromVisits(toRemove);
        pet.addToVisits(items);
        return petRepository.save(pet);
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param pet
     */
    @Transactional
    public void PetServiceImpl.delete(Pet pet) {
        // Clear bidirectional many-to-one child relationship with Owner
        if (pet.getOwner() != null) {
            pet.getOwner().getPets().remove(pet);
        }
        
        // Clear bidirectional one-to-many parent relationship with Visit
        for (Visit item : pet.getVisits()) {
            item.setPet(null);
        }
        
        petRepository.delete(pet);
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param entities
     * @return List
     */
    @Transactional
    public List<Pet> PetServiceImpl.save(Iterable<Pet> entities) {
        return petRepository.save(entities);
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param ids
     */
    @Transactional
    public void PetServiceImpl.delete(Iterable<Long> ids) {
        List<Pet> toDelete = petRepository.findAll(ids);
        petRepository.deleteInBatch(toDelete);
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param entity
     * @return Pet
     */
    @Transactional
    public Pet PetServiceImpl.save(Pet entity) {
        return petRepository.save(entity);
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param id
     * @return Pet
     */
    public Pet PetServiceImpl.findOne(Long id) {
        return petRepository.findOne(id);
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param ids
     * @return List
     */
    public List<Pet> PetServiceImpl.findAll(Iterable<Long> ids) {
        return petRepository.findAll(ids);
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @return List
     */
    public List<Pet> PetServiceImpl.findAll() {
        return petRepository.findAll();
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @return Long
     */
    public long PetServiceImpl.count() {
        return petRepository.count();
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param globalSearch
     * @param pageable
     * @return Page
     */
    public Page<Pet> PetServiceImpl.findAll(GlobalSearch globalSearch, Pageable pageable) {
        return petRepository.findAll(globalSearch, pageable);
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param owner
     * @param globalSearch
     * @param pageable
     * @return Page
     */
    public Page<Pet> PetServiceImpl.findByOwner(Owner owner, GlobalSearch globalSearch, Pageable pageable) {
        return petRepository.findByOwner(owner, globalSearch, pageable);
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param owner
     * @return Long
     */
    public long PetServiceImpl.countByOwner(Owner owner) {
        return petRepository.countByOwner(owner);
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param owner
     * @param pageable
     * @return Page
     */
    public Page<Pet> PetServiceImpl.findByOwner(Owner owner, Pageable pageable) {
        return petRepository.findByOwner(owner, pageable);
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param sendReminders
     * @param weight
     * @param pageable
     * @return Page
     */
    public Page<Pet> PetServiceImpl.findBySendRemindersAndWeightLessThan(boolean sendReminders, Float weight, Pageable pageable) {
        return petRepository.findBySendRemindersAndWeightLessThan(sendReminders, weight, pageable);
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param type
     * @param name
     * @param pageable
     * @return Page
     */
    public Page<Pet> PetServiceImpl.findByTypeAndNameLike(PetType type, String name, Pageable pageable) {
        return petRepository.findByTypeAndNameLike(type, name, pageable);
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param formBean
     * @param globalSearch
     * @param pageable
     * @return Page
     */
    public Page<Pet> PetServiceImpl.findByNameAndWeight(PetNameAndWeightFormBean formBean, GlobalSearch globalSearch, Pageable pageable) {
        return petRepository.findByNameAndWeight(formBean, globalSearch, pageable);
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param sendReminders
     * @param weight
     * @return Long
     */
    public long PetServiceImpl.countBySendRemindersAndWeightLessThan(boolean sendReminders, Float weight) {
        return petRepository.countBySendRemindersAndWeightLessThan(sendReminders, weight);
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param type
     * @param name
     * @return Long
     */
    public long PetServiceImpl.countByTypeAndNameLike(PetType type, String name) {
        return petRepository.countByTypeAndNameLike(type, name);
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param formBean
     * @return Long
     */
    public long PetServiceImpl.countByNameAndWeight(PetNameAndWeightFormBean formBean) {
        return petRepository.countByNameAndWeight(formBean);
    }
    
}
