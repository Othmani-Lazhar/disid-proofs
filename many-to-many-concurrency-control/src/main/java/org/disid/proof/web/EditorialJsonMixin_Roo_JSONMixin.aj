// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.disid.proof.web;

import com.fasterxml.jackson.annotation.JsonIgnore;
import java.util.Set;
import org.disid.proof.domain.Book;
import org.disid.proof.web.EditorialJsonMixin;

privileged aspect EditorialJsonMixin_Roo_JSONMixin {
    
    /**
     * TODO Auto-generated attribute documentation
     * 
     */
    @JsonIgnore
    private Set<Book> EditorialJsonMixin.books;
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @return Set
     */
    public Set<Book> EditorialJsonMixin.getBooks() {
        return books;
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param books
     */
    public void EditorialJsonMixin.setBooks(Set<Book> books) {
        this.books = books;
    }
    
}
