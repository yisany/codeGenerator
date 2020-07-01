
import java.util.List;

/**
* @author by ${authorName} on ${.now?string('yyyy-MM-dd')}
*/
public interface I${classInfoDTO.className}DAO {

    int add(${classInfoDTO.className} ${classInfoDTO.className?uncap_first});

    int update(${classInfoDTO.className} ${classInfoDTO.className?uncap_first});

    int delete(int id);

    ${classInfoDTO.className} findById(int id);

    List<${classInfoDTO.className}> findAllList(Map<String,Object> param);

}
