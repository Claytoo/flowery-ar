using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Backsound : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        if(GameObject.Find("backsound on") == null)
        {
            DontDestroyOnLoad(gameObject);
            GetComponent<AudioSource>().Play();
            gameObject.name = "backsound nyala";
            PlayerPrefs.SetFloat("volume", 1);
        }
    }

    // Update is called once per frame
    void Update()
    {
        GetComponent<AudioSource>().volume = PlayerPrefs.GetFloat("volume");
    }
}
