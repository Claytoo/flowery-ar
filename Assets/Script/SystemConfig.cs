using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SystemConfig : MonoBehaviour
{
    public static SystemConfig instance;
    public GameObject GUI_AR;

    private void Awake()
    {
        instance = this;
    }
    // Start is called before the first frame update
    void Start()
    {
        GUI_AR.SetActive(true);
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
