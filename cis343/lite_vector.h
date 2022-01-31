#ifndef		H_VECTOR_LITE
#define		H_VECTOR_LITE

#include <stdbool.h>
#include <stdlib.h>

/**
 * lite_vector.{c,h}
 * Ira Woodring
 *
 * A lite vector is a struct that holds a current length, a maximum capacity,
 * and a dynamically allocated chunk of memory.  It will hold elements added
 * and will extend the memory if it needs more space.
 *
 *  Note that written as is it will only hold *pointers* to any kind of data.
 * 
 * So if you are passing a char* (string), no worries, just pass the char*.  But,
 * If you wish to store a non-pointer type, you will need to pass the address.
 * For instance, if you wish to store ints, you must
 *
 * int x = 42;
 * lv_append(lv, &x);
 *
 * This means that if x changes sometime before you retrieve it with a lv_get(),
 * you will get the *new* value as you are just storing an address.
 *
 * This also means that if for some reason the variable goes out of scope
 * or the the lifetime ends for that variable, you run the risk of 
 * a memory error.
 * 
 * A better alternative for a vector implementation would likely be macro
 * based, where the compiler can create a specific vector implementation for our
 * type based on a template.
 *
 * However, that wouldn't cause you nearly as many problems with pointers, and
 * since you need to learn them (really well!), we complete this version
 * instead!
 * 
 * This also means that the type_size is essentially worthless.  I'm leaving it
 * here to see who reads the comments as they should.
 */
typedef struct lv {
	size_t length;
	size_t max_capacity;
	size_t type_size;
	void** data;
} lite_vector;

/**
 * Create a new lite_vector.
 *
 * @param type_size The number of bytes for a single element of the type
 *                  to be stored in the vector.
 * @return The vector, or NULL if the operation fails.
 */
lite_vector* lv_new_vec(size_t type_size);

/**
 * Free all memory used by the vector.  Should be called
 * whenever the vector is no longer needed.
 *
 * @param vec The address of the vector we are finished using.
 */
void lv_cleanup(lite_vector* vec);

/**
 * Clear the contents of the vector and reset it to a default state.
 *
 * @param vec The address of the vector we wish to clear.
 * @retun Sends true on success, or false otherwise.
 */
bool lv_clear(lite_vector* vec);

/**
 * Get the current number of elements stored in the vector.
 *
 * @param vec The address of the vector we want to know the length of.
 * @return The vector length, or 0 if the operation fails.
 */
size_t lv_get_length(lite_vector* vec);

/**
 * Get an element from an index from a vector.
 *
 * @param vec The address of the vector we wish to retrieve from.
 * @param index The index we wish to retrieve from.
 * @return An element from the vector.  NULL if doesn't exist or
 *	   the function cannot complete.
 */
void* lv_get(lite_vector* vec, size_t index);

/**
 * Add an element to the vector, and extend the vector if needed.
 *
 * @param vec The address of the vector we wish to add to.
 * @param element The element we wish to add.
 * @return Will return true if successful, false otherwise.
 */
bool lv_append(lite_vector* vec, void* element);

#endif