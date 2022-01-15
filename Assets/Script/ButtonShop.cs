using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ButtonShop : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        
    }

    public void OpenURL()
    {
        Application.OpenURL("https://tokopedia.com/");
        Debug.Log("Shop Link Work!");
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
