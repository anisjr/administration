package cloudupload;

import com.google.appengine.api.blobstore.BlobKey;
import com.google.appengine.api.images.ImagesService;
import com.google.appengine.api.images.ImagesServiceFactory;
import com.google.appengine.api.images.ServingUrlOptions;

import java.util.Date;
import com.googlecode.objectify.annotation.*;


@Entity
@Cache
public class Upload {
    @Id Long id;
    @Index Date date;
    String image;
    @Index BlobKey key;
    String nom;
    String utilisateur;
    String url;
    
    private Upload() {}
    public Upload(BlobKey key, String nom, String utilisateur, String url) {
        ImagesService imagesService = ImagesServiceFactory.getImagesService();
        
        this.date = new Date();
        this.key = key;
        this.image = imagesService.getServingUrl(ServingUrlOptions.Builder.withBlobKey(key));
        this.nom = nom;
        this.utilisateur = utilisateur;
        this.url = url;
    }
    

    public String getImage() {
        return image;
    }
    public BlobKey getKey() {
        return key;
    }
    public String getKeyString() {
        return key.getKeyString();
    }
    public String getNom() {
        return nom;
    }
    public void setNom(String nom) {
        this.nom = nom;
    }
    public void setUrl(String url) {
		this.url = url;
	}
    public void setUtilisateur(String utilisateur) {
		this.utilisateur = utilisateur;
	}
    public String getUrl() {
		return url;
	}
    public String getUtilisateur() {
		return utilisateur;
	}
    
}
