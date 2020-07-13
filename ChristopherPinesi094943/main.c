#include<stdlib.h>
#include<string.h>
#include<stdio.h>
#include<time.h>


typedef enum {
    INSERTION,
    DELETION,
    SUBSTITUTION,
    NONE
} edit_type;



struct edit {
    unsigned int score;
    edit_type type;
    char arg1;
    char arg2;
    unsigned int pos;
    struct edit *prev;
};
typedef struct edit edit;
static int min3(int a, int b, int c)
{
    if (a < b && a < c) {
        return a;
    }
    if (b < a && b < c) {
        return b;
    }
    return c;
}

static unsigned int matrix_calculate(edit **mat, const char *file1, size_t len1,
                                                 const char *file2, size_t len2)
{
    unsigned int i, j;
    for (j = 1; j <= len2; j++) {
        for (i = 1; i <= len1; i++) {
            unsigned int substitution_cost;
            unsigned int DEL = 0, ADD = 0, SET = 0;
            unsigned int best;
            if (file1[i - 1] == file2[j - 1]) {
                substitution_cost = 0;
            }
            else {
                substitution_cost = 1;
            }
            DEL = mat[i - 1][j].score + 1; /* deletion */
            ADD = mat[i][j - 1].score + 1; /* insertion */
            SET = mat[i - 1][j - 1].score + substitution_cost; /* substitution */
            best = min3(DEL, ADD, SET);
            mat[i][j].score = best;
            mat[i][j].arg1 = file1[i - 1];
            mat[i][j].arg2 = file2[j - 1];
            mat[i][j].pos = i - 1;
            if (best == DEL) {
                mat[i][j].type = DELETION;
                mat[i][j].prev = &mat[i - 1][j];
            }
            else if (best == ADD) {
                mat[i][j].type = INSERTION;
                mat[i][j].prev = &mat[i][j - 1];
            }
            else {
                if (substitution_cost > 0) {
                    mat[i][j].type = SUBSTITUTION;
                }
                else {
                    mat[i][j].type = NONE;
                }
                mat[i][j].prev = &mat[i - 1][j - 1];
            }
        }
    }
    return mat[len1][len2].score;
}

static edit **matrix_create(const char *file1, size_t len1, const char *file2,
                                        size_t len2)
{
    unsigned int i, j;
    edit **mat = malloc((len1 + 1) * sizeof(edit *));
    if (mat == NULL) {
        return NULL;
    }
    for (i = 0; i <= len1; i++) {
        mat[i] = malloc((len2 + 1) * sizeof(edit));
        if (mat[i] == NULL) {
            for (j = 0; j < i; j++) {
                free(mat[j]);
            }
            free(mat);
            return NULL;
        }
    }
    for (i = 0; i <= len1; i++) {
        mat[i][0].score = i;
        mat[i][0].prev = NULL;
        mat[i][0].arg1 = 0;
        mat[i][0].arg2 = 0;
    }

    for (j = 0; j <= len2; j++) {
        mat[0][j].score = j;
        mat[0][j].prev = NULL;
        mat[0][j].arg1 = 0;
        mat[0][j].arg2 = 0;
    }
    return mat;
}
unsigned int fdistance(const char *file1, const char *file2, edit **script) {
    const size_t len1 = strlen(file1), len2 = strlen(file2);
    unsigned int i, distance;
    edit **mat, *head;

    /*Se una delle stringhe è vuota, la distanza è la lunghezza dell'altra stringa */
    if (len1 == 0) {
        return len2;
    }
    if (len2 == 0) {
        return len1;
    }
    /* Inizializza la matrice */
    mat = matrix_create(file1, len1, file2, len2);
    if (!mat) {
        *script = NULL;
        return 0;
    }
    /* Algoritmo principale */
    distance = matrix_calculate(mat, file1, len1, file2, len2);
    *script = malloc(distance * sizeof(edit));
    if (*script) {
        i = distance - 1;
        for (head = &mat[len1][len2];
             head->prev != NULL;
             head = head->prev) {
            if (head->type != NONE) {
                memcpy(*script + i, head, sizeof(edit));
                i--;
            }
        }
    } else {
        distance = 0;
    }
    /* Pulizia */
    for (i = 0; i <= len1; i++) {
        free(mat[i]);
    }
    free(mat);

    return distance;
}
int print(const edit *e) {
    if (e->type == INSERTION) {
        printf("Inserimento %c", e->arg2);
    } else if (e->type == DELETION) {
        printf("Cancellazione %c", e->arg1);
    } else {
        printf("Sostituzione %c for %c", e->arg2, e->arg1);
    }
    printf(" at %u\n", e->pos);
    return 0;
}
    int filedistance(void) {
        clock_t start = clock();
        edit *script;
        unsigned int distance;
        unsigned int i;
        char file1[25];
        char file2[25];
        printf("Nome del primo file\n");
        scanf("%s", file1);
        printf("Nome del secondo file\n");
        scanf("%s", file2);
        distance = fdistance(file1, file2, &script);
        printf("La distanza e' %d:\n", distance);
        for (i = 0; i < distance; i++) {
            print(&script[i]);
        }
        free(script);
        clock_t stop = clock();
        double elapsed = (double) (stop - start) * 1000.0 / CLOCKS_PER_SEC;
        printf("Time in ms: %f", elapsed);
        return 0;
    }
    int distanceoutput(void) {
        FILE *fd;
        edit *script;
        unsigned int distance;
        unsigned int i;
        char file1[20];
        char file2[20];
        printf("Nome del primo file\n");
        scanf("%s", file1);
        printf("Nome del secondo file\n");
        scanf("%s", file2);
        fd = fopen("filem.txt", "w+");
        if (fd == NULL) {
            perror("Errore in apertura del file");
            exit(1);
        }
        distance = fdistance(file1, file2, &script);
        fprintf(fd,"La distanza e': %d\n", distance);
        for (i = 0; i < distance; i++) {
            print(&script[i]);
        }
        printf("La distanza e' stata salvate nel filem\n");
        fclose(fd);
        return 0;
    }
/*void stampaLibri(int pos)
{
    int i=0;
    while(i<pos)
    {
        printf("\n\nCodice libro: %s", archivio_libri[i].id);
        printf("\nTitolo %s ", archivio_libri[i].titolo);
        printf("\nGenere %s: ", archivio_libri[i].titolo);

        i++;
    }
}

int insertLibri(int pos)
{
    char invio;
    char c;

    if(pos>=N) {
        printf("\n\nHai raggiunto il limite massimo di libri che puoi inserire ");

        scanf("%c", &invio);
        return(pos);
    }

    fflush(stdin);
    printf("\nISBN:");
    gets(archivio_libri[pos].id);
    fflush(stdin);
    printf("\nTitolo:");
    gets(archivio_libri[pos].titolo);
    printf("\ngenere:");
    gets(archivio_libri[pos].genere);
    fflush(stdin);

    pos++;
    return(pos);
}

void stampaGenere(int pos)
{
    char genere[40];
    int i=0, trovato=0;

    printf("\nQuale genere cerchi?:");
    scanf("%s", genere);

    for (i=0; i<pos; i++){
        if(strcmp(archivio_libri[i].genere,genere)==0) {
            printf("\n\n ISBN: %s ", archivio_libri[i].id);
            printf("\n Titolo: %s ", archivio_libri[i].titolo);
            trovato=1;
        }
    }
    if (trovato==0)
        printf("\nNon e' presente nessuna categoria:");
}*/
int menu_scelta(void)
{
    int selezione = 0;
    do
    {
        printf("\n" );
        printf("\n1 - Calcolo della distanza tra due file " );
        printf("\n2 - Salva la distanza tra i file");
        printf("\n3 - Ricerca libro per genere");
        printf("\n4 - Esci");
        printf("\n Effettua una scelta: " );
        scanf("%d", &selezione );
    }
    while (selezione < 1 || selezione > 4);
    return selezione;
}

int main()
{
    int scelta;

    while((scelta=menu_scelta())!=4){
        switch(scelta){
            case 1:
                filedistance();
                break;
            case 2:
                distanceoutput();
                break;
            case 3:

                break;
            case 4: break;
        }
    }
    return 0;
}